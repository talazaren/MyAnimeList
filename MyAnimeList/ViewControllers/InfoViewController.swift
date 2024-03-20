//
//  InfoViewController.swift
//  MyAnimeList
//
//  Created by Tatiana Lazarenko on 3/19/24.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet var synopsisLabel: UILabel!
    @IBOutlet var japaneseLabel: UILabel!
    @IBOutlet var mainImageView: UIImageView!
    
    var animeInfo: AnimeDataStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        let networkManager = NetworkManager.shared
        
        let titles = animeInfo.titles
        let titleLabel = UILabel()
        titles.forEach { title in
            if title.type == "Default" {
                titleLabel.text = title.title
            }
        }
        navigationItem.title = titleLabel.text
        // Аналогичный вопрос с переносом текста :(
        
        titles.forEach { title in
            if title.type == "Japanese" {
                japaneseLabel.text = title.title
            }
        }
    
        let imageURL = URL(string: animeInfo.images.jpg.imageUrl)!
        networkManager.fetchImage(from: imageURL) { [unowned self] result in
            switch result {
            case .success(let imageData):
                mainImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
        
        synopsisLabel.text = animeInfo.synopsis
        // Как сделать, чтобы скроллвью скроллился?
    }
}
