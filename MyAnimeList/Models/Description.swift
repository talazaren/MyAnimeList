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
        images = Images.getImages(from: animeDataStoreDetails["images"] as Any)
        titles = Title.getTitles(from: animeDataStoreDetails["titles"] as Any)
        genres = Genre.getGenres(from: animeDataStoreDetails["genres"] as Any)
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
        guard
            let image = imagesDetails["jpg"] as? [String: String],
            let imageUrl = image["image_url"] else {
            jpg = Image(image_url: "")
            return
        }
        jpg = Image(image_url: imageUrl)
    }
    
    static func getImages(from value: Any) -> Images {
        guard let images = value as? [String: Any] else {
            return Images.init(imagesDetails: [:])
        }
        
        return Images.init(imagesDetails: images)
    }
}

struct Image {
    let image_url: String
}

struct Title {
    let type: String
    let title: String
    
    init(type: String, title: String) {
        self.type = type
        self.title = title
    }
    
    init(titleDetails: [String: String]) {
        type = titleDetails["type"] ?? ""
        title = titleDetails["title"] ?? ""
    }
    
    static func getTitles(from value: Any) -> [Title] {
        guard let titlesDetails = value as? [[String: String]] else { return [] }
        return titlesDetails.map { Title.init(titleDetails: $0) }
    }
}

struct Genre {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    init(genreDetails: [String: Any]) {
        guard let genreName = genreDetails["name"] as? String else {
            name = ""
            return
        }
        name = genreName
    }
    
    static func getGenres(from value: Any) -> [Genre] {
        guard let genresDetails = value as? [[String: Any]] else { return [] }
        return genresDetails.map { Genre.init(genreDetails: $0) }
    }
}
