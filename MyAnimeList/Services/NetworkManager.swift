//
//  NetworkManager.swift
//  MyAnimeList
//
//  Created by Tatiana Lazarenko on 3/19/24.
//

import Foundation
import Alamofire

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
    
    func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
    }
    
    func fetch(from url: URL, completion: @escaping(Result<[AnimeDataStore], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let animeData = AnimeDataStore.getAnimeList(from: value)
                    completion(.success(animeData))
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
    }
    
}
