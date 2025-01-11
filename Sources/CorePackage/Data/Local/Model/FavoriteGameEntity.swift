//
//  FavoriteGameEntity.swift
//  gamv
//
//  Created by Ajie DR on 28/11/24.
//

import SwiftData

@Model
public final class FavoriteGameEntity{
    public var id: Int
    public var title: String
    public var releaseDate: String
    public var rating: Double
    public var imageUrl: String
    public var esrbRating: String
    public var platforms: [PlatformEntity]
    public var genres: [GenreEntity]
    
    init(id: Int, title: String, releaseDate: String, rating: Double, imageUrl: String, esrbRating: String, platforms: [PlatformEntity], genres: [GenreEntity]) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.rating = rating
        self.imageUrl = imageUrl
        self.esrbRating = esrbRating
        self.platforms = platforms
        self.genres = genres
    }
}

@Model
public class PlatformEntity {
    public var id: Int
    public var name: String
    public var minimumRequirements: String
    public var recommendedRequirements: String
    
    init(id: Int, name: String, minimumRequirements: String, recommendedRequirements: String) {
        self.id = id
        self.name = name
        self.minimumRequirements = minimumRequirements
        self.recommendedRequirements = recommendedRequirements
    }
}

@Model
public class GenreEntity {
    public var id: Int
    public var name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
