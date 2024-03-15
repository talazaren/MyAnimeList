//
//  Description.swift
//  MyAnimeList
//
//  Created by Tatiana Lazarenko on 3/15/24.
//

import Foundation

struct AnimeDescription: Decodable {
    let data: [Data]
}

struct Data: Decodable {
    let images: Images
    let titles: [Title]
    let genres: [Genre]
}

struct Images: Decodable {
    let jpg: Image
}

struct Image: Decodable {
    let image_url: String
}

struct Title: Decodable {
    let type: String
    let title: String
}

struct Genre: Decodable {
    let name: String
}
