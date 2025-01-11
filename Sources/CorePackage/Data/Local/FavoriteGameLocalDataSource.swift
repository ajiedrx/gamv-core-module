//
//  LocalDataSource.swift
//  gamv
//
//  Created by Ajie DR on 28/11/24.
//

import Combine
import Foundation
import SwiftData

final class FavoriteGameLocalDataSource {
    private let modelContext: ModelContext
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
        }

    func fetchFavoriteGameEntity() -> AnyPublisher<
        [FavoriteGameEntity], CommonError
    > {
        return Future { [modelContext] promise in
            do {
                let result = try self.modelContext.fetch(
                    FetchDescriptor<FavoriteGameEntity>())
                promise(.success(result))
            } catch {
                promise(.failure(.unknownError(error.localizedDescription)))
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }

    func fetchFavoriteGameEntityIds() -> AnyPublisher<[Int], CommonError> {
        return Future { [modelContext] promise in
            do {
                var fetchDescriptor = FetchDescriptor<FavoriteGameEntity>()
                fetchDescriptor.propertiesToFetch = [\.id]

                let result = try self.modelContext.fetch(fetchDescriptor).map {
                    result in
                    result.id
                }
                promise(.success(result))
            } catch {
                promise(.failure(.unknownError(error.localizedDescription)))
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }

    func addFavoriteGameEntity(entity: FavoriteGameEntity) -> AnyPublisher<Void, Never> {
        return Future { [modelContext] promise in
            do {
                self.modelContext.insert(entity)
                try self.modelContext.save()
            } catch {}
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }

    func removeFavoriteGameEntity(entity: FavoriteGameEntity) -> AnyPublisher<Void, Never> {
        return Future { [modelContext] promise in
            do {
                let toBeDeletedGame = entity.id
                
                try self.modelContext.delete(
                    model: FavoriteGameEntity.self,
                    where: #Predicate<FavoriteGameEntity> { game in
                        game.id == toBeDeletedGame
                    })
                try self.modelContext.save()
            } catch {}
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

extension ModelContext {
    var sqliteCommand: String {
        if let url = container.configurations.first?.url.path(
            percentEncoded: false)
        {
            "sqlite3 \"\(url)\""
        } else {
            "No SQLite database found."
        }
    }
}
