//
//  Description.swift
//  MyAnimeList
//
//  Created by Tatiana Lazarenko on 3/15/24.
//

import Foundation

struct AnimeDataStore {
    let images: Images
    let titles: [Title]
    let genres: [Genre]
    let synopsis: String
    
    init(images: Images, titles: [Title], genres: [Genre], synopsis: String) {
        self.images = images
        self.titles = titles
        self.genres = genres
        self.synopsis = synopsis
    }
    
    init(animeDataStoreDetails: [String: Any]) {
        let imagesDetails = animeDataStoreDetails["images"] as? [String: Any] ?? [:]
        images = Images(imagesDetails: imagesDetails)
        
        let titlesDetails = animeDataStoreDetails["titles"] as? [[String: Any]] ?? []
        titles = titlesDetails.map({ Title(titleDetails: $0) })
        
        let genreDetails = animeDataStoreDetails["genres"] as? [[String: Any]] ?? []
        genres = genreDetails.map({ Genre(genreDetails: $0) })
        
        synopsis = animeDataStoreDetails["synopsis"] as? String ?? ""
    }
    
    static func getAnimeList(from value: Any) -> [AnimeDataStore] {
        guard let response = value as? [String: Any] else { return [] }
        guard let dataFromResponse = response["data"] as? [[String: Any]] else { return [] }
        return dataFromResponse.map { AnimeDataStore(animeDataStoreDetails: $0) }
    }
}

struct Images {
    let jpg: Image
    
    init(jpg: Image) {
        self.jpg = jpg
    }
    
    init(imagesDetails: [String: Any]) {
        let jpgDetails = imagesDetails["jpg"] as? [String: String] ?? [:]
        jpg = Image(imageDetails: jpgDetails)
    }
}

struct Image {
    let imageUrl: String
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
    
    init(imageDetails: [String: String]) {
        imageUrl = imageDetails["image_url"] ?? ""
    }
}

struct Title {
    let type: String
    let title: String
    
    init(type: String, title: String) {
        self.type = type
        self.title = title
    }
    
    init(titleDetails: [String: Any]) {
        type = titleDetails["type"] as? String ?? ""
        title = titleDetails["title"] as? String ?? ""
    }
}

struct Genre {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    init(genreDetails: [String: Any]) {
        name = genreDetails["name"] as? String ?? ""
    }
}
