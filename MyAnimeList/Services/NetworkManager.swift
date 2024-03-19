//
//  NetworkManager.swift
//  MyAnimeList
//
//  Created by Tatiana Lazarenko on 3/19/24.
//

import Foundation

enum Link {
    case myAnimeListURL
    
    var url: URL {
        switch self {
        case .myAnimeListURL:
            return URL(string: "https://api.jikan.moe/v4/anime")!
        }
    }
}

enum NetworkError: Error {
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetch(from url: URL, completion: @escaping(Result<AnimeDescription, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let dataModel = try decoder.decode(AnimeDescription.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
    
}
