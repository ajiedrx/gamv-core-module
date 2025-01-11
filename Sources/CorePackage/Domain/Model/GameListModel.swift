//
//  GameListModel.swift
//  gamv
//
//  Created by Ajie DR on 17/11/24.
//

import Foundation

public struct GameListModel {
    public let count: Int?
    public let next: String?
    public let previous: String?
    public let results: [GameListItemModel]?
    
    public init(count: Int?, next: String?, previous: String?, results: [GameListItemModel]?) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

public struct GameListItemModel: Identifiable, Hashable, Equatable {
    public let id: Int?
    public let slug, name, released: String
    public let tba: Bool?
    public let backgroundImage: String
    public let rating: Double
    public let ratingTop: Int?
    public let ratings: [Rating]?
    public let ratingsCount, reviewsTextCount, added: Int?
    public let metacritic, playtime, suggestionsCount: Int?
    public let updated: String?
    public let reviewsCount: Int?
    public let platforms: [PlatformElement]?
    public let parentPlatforms: [ParentPlatform]?
    public let genres: [Genre]?
    public let stores: [Store]?
    public let esrbRating: EsrbRating?
    public let shortScreenshots: [ShortScreenshot]?
    public var isFavorite: Bool = false
    
    public init(id: Int?, slug: String, name: String, released: String, tba: Bool?, backgroundImage: String,
                rating: Double, ratingTop: Int?, ratings: [Rating]?, ratingsCount: Int?, reviewsTextCount: Int?,
                added: Int?, metacritic: Int?, playtime: Int?, suggestionsCount: Int?, updated: String?,
                reviewsCount: Int?, platforms: [PlatformElement]?, parentPlatforms: [ParentPlatform]?,
                genres: [Genre]?, stores: [Store]?, esrbRating: EsrbRating?, shortScreenshots: [ShortScreenshot]?,
                isFavorite: Bool = false) {
        self.id = id
        self.slug = slug
        self.name = name
        self.released = released
        self.tba = tba
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.ratingTop = ratingTop
        self.ratings = ratings
        self.ratingsCount = ratingsCount
        self.reviewsTextCount = reviewsTextCount
        self.added = added
        self.metacritic = metacritic
        self.playtime = playtime
        self.suggestionsCount = suggestionsCount
        self.updated = updated
        self.reviewsCount = reviewsCount
        self.platforms = platforms
        self.parentPlatforms = parentPlatforms
        self.genres = genres
        self.stores = stores
        self.esrbRating = esrbRating
        self.shortScreenshots = shortScreenshots
        self.isFavorite = isFavorite
    }
}

public struct EsrbRating: Identifiable, Hashable, Equatable {
    public let id: Int?
    public let name, slug: String?
    
    public init(id: Int?, name: String?, slug: String?) {
        self.id = id
        self.name = name
        self.slug = slug
    }
}

public struct Genre: Identifiable, Hashable, Equatable {
    public let id: Int?
    public let name, slug: String?
    public let gamesCount: Int?
    public let imageBackground: String?
    public let domain: String?
    public let language: String?
    
    public init(id: Int?, name: String?, slug: String?, gamesCount: Int?,
                imageBackground: String?, domain: String?, language: String?) {
        self.id = id
        self.name = name
        self.slug = slug
        self.gamesCount = gamesCount
        self.imageBackground = imageBackground
        self.domain = domain
        self.language = language
    }
}

public struct ParentPlatform: Identifiable, Hashable, Equatable {
    public let id: String = UUID().uuidString
    public let platform: EsrbRating?
    
    public init(platform: EsrbRating?) {
        self.platform = platform
    }
}

public struct PlatformElement: Identifiable, Hashable, Equatable {
    public let id: String = UUID().uuidString
    public let platform: PlatformPlatform?
    public let releasedAt: String?
    public let requirementsEn, requirementsRu: Requirements?
    
    public init(platform: PlatformPlatform?, releasedAt: String?,
                requirementsEn: Requirements?, requirementsRu: Requirements?) {
        self.platform = platform
        self.releasedAt = releasedAt
        self.requirementsEn = requirementsEn
        self.requirementsRu = requirementsRu
    }
}

public struct PlatformPlatform: Identifiable, Hashable, Equatable {
    public let id: Int?
    public let name, slug: String?
    public let yearStart: Int?
    public let gamesCount: Int?
    public let imageBackground: String?
    
    public init(id: Int?, name: String?, slug: String?, yearStart: Int?,
                gamesCount: Int?, imageBackground: String?) {
        self.id = id
        self.name = name
        self.slug = slug
        self.yearStart = yearStart
        self.gamesCount = gamesCount
        self.imageBackground = imageBackground
    }
}

public struct Requirements: Identifiable, Hashable, Equatable {
    public let id: String = UUID().uuidString
    public let minimum, recommended: String?
    
    public init(minimum: String?, recommended: String?) {
        self.minimum = minimum
        self.recommended = recommended
    }
}

public struct Rating: Identifiable, Hashable, Equatable {
    public let id: Int?
    public let title: String?
    public let count: Int?
    public let percent: Double?
    
    public init(id: Int?, title: String?, count: Int?, percent: Double?) {
        self.id = id
        self.title = title
        self.count = count
        self.percent = percent
    }
}

public struct ShortScreenshot: Identifiable, Hashable, Equatable {
    public let id: Int?
    public let image: String?
    
    public init(id: Int?, image: String?) {
        self.id = id
        self.image = image
    }
}

public struct Store: Identifiable, Hashable, Equatable {
    public let id: Int?
    public let store: Genre?
    
    public init(id: Int?, store: Genre?) {
        self.id = id
        self.store = store
    }
}
