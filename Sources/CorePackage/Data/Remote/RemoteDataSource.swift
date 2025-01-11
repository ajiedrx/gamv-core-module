//
//  RemoteDataSource.swift
//  gamv
//
//  Created by Ajie DR on 14/11/24.
//

import Foundation
import Combine

protocol RemoteDataSourceProtocol {
    func getListOfGames(page: Int, search: String) -> AnyPublisher<GameListResponse, CommonError>
}

final class RemoteDataSource: NSObject {
    private override init () {}
    @MainActor static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getListOfGames(page: Int, search: String) -> AnyPublisher<GameListResponse, CommonError> {
        guard let url = URL(string: Endpoints.Gets.games.url) else {
            return Fail(error: CommonError.addressUnreachable(Endpoints.Gets.games.url))
                .eraseToAnyPublisher()
        }
        
        let urlComponents = self.getUrlComponents(url: url, page: page, search: search)
        let request = self.getRequest(urlComponents: urlComponents, method: .GET)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { [weak self] data, response -> GameListResponse in
                guard let self = self else {
                    throw CommonError.unknownError("Self is nil")
                }
                return try self.getResponse(response: response, data: data)
            }
            .mapError { error -> CommonError in
                if let commonError = error as? CommonError {
                    return commonError
                }
                return .unknownError(error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
    private func getUrlComponents(url: URL, page: Int, search: String) -> URLComponents {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "search", value: search),
            URLQueryItem(name: "key", value: API.API_KEY)
        ]
        
        urlComponents.queryItems = queryItems
        
        return urlComponents
    }
    
    private func getRequest(urlComponents: URLComponents, method: HTTPMethod) -> URLRequest {
        var request = URLRequest(url: urlComponents.url!)
        
        request.httpMethod = method.method
        request.timeoutInterval = 30
        
        return request
    }
    
    private func getResponse<T : Decodable> (response: URLResponse, data: Data) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
        else { throw CommonError.invalidResponse }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw CommonError.invalidResponse
        }
    }
}
