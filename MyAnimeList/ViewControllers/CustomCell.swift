//
//  CustomCell.swift
//  MyAnimeList
//
//  Created by Tatiana Lazarenko on 3/15/24.
//

import UIKit

final class CustomCell: UICollectionViewCell {
    @IBOutlet var animeGenresLabel: UILabel!
    @IBOutlet var animeTitleLabel: UILabel!
    @IBOutlet var animeImageView: UIImageView!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with descriptions: AnimeDataStore) {
        let titles = descriptions.titles
        var titleLabel = ""
        titles.forEach { title in
            if title.type == "Default" {
                titleLabel = title.title
            }
        }
        animeTitleLabel.text = titleLabel
        // Подскажите пожалуйста, как делать перенос текста?
        
        let genres = descriptions.genres
        var genreLabel = ""
        genres.forEach { genre in
            genreLabel += "\(genre.name) "
        }
        animeGenresLabel.text = genreLabel
        
        let imageURL = URL(string: descriptions.images.jpg.imageUrl)!
        networkManager.fetchImage(from: imageURL) { [unowned self] result in
            switch result {
            case .success(let imageData):
                animeImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
