//
//  Description.swift
//  MyAnimeList
//
//  Created by Tatiana Lazarenko on 3/15/24.
//

import Foundation

struct AnimeDescription: Decodable {
    let data: [AnimeDataStore]
}

struct AnimeDataStore: Decodable {
    let images: Images
    let titles: [Title]
    let genres: [Genre]
    /*let year: Int
    let episodes: Int
    let studios: [Studio]
    let score: Double
    let synopsis: String
    let background: String*/
}

struct Images: Decodable {
    let jpg: Image
}

struct Image: Decodable {
    let imageUrl: String
}

struct Title: Decodable {
    let type: String
    let title: String
}

struct Genre: Decodable {
    let name: String
}

struct Studio: Decodable {
    let type: String
    let name: String
}

