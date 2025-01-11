//
//  GetFavoriteGameListUseCase.swift
//  gamv
//
//  Created by Ajie DR on 05/01/25.
//

import Foundation
import Combine

public class GetFavoriteGameListUseCase {
    private let gameRepository: GameRepositoryProtocol
    
    public required init(gameRepository: GameRepositoryProtocol) {
        self.gameRepository = gameRepository
    }
    
    public func execute() -> AnyPublisher<[GameListItemModel], CommonError> {
        return gameRepository.fetchFavoriteGamesFromLocal()
    }
}
