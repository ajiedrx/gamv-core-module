//
//  Injeciton.swift
//  gamv
//
//  Created by Ajie DR on 17/11/24.
//

import Foundation
import SwiftData

public final class Injection: NSObject {
    private var modelContainer: ModelContainer?

    @MainActor
    private func provideRepository() -> GameRepositoryProtocol {
        if let existingContainer = modelContainer {
            return GameRepository.getInstance(
                remote: RemoteDataSource.sharedInstance,
                local: FavoriteGameLocalDataSource(
                    modelContext: ModelContext(modelContainer!)
                )
            )
        }
        
        do {
            let schema = Schema([FavoriteGameEntity.self])
            let modelConfiguration = ModelConfiguration(schema: schema)
            let container = try ModelContainer(for: schema, configurations: modelConfiguration)
            modelContainer = container
            
            return GameRepository.getInstance(
                remote: RemoteDataSource.sharedInstance,
                local: FavoriteGameLocalDataSource(
                    modelContext: ModelContext(modelContainer!)
                )
            )
        } catch {
            // Handle error appropriately
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
    
    @MainActor public func provideGetGameListUseCase() -> GetGameListUseCase {
        let repository = provideRepository()
        
        return GetGameListUseCase(gameRepository: repository)
    }
    
    @MainActor public func provideGetFavoriteGameListUseCase() -> GetFavoriteGameListUseCase {
        let repository = provideRepository()
        
        return GetFavoriteGameListUseCase(gameRepository: repository)
    }
    
    @MainActor public func provideAddFavoriteGameUseCase() -> AddFavoriteGameUseCase {
        let repository = provideRepository()
        
        return AddFavoriteGameUseCase(gameRepository: repository)
    }
    
    @MainActor public func provideRemoveFavoriteGameUseCase() -> RemoveFavoriteGameUseCase {
        let repository = provideRepository()
        
        return RemoveFavoriteGameUseCase(gameRepository: repository)
    }
}


