//
//  InfoViewController.swift
//  MyAnimeList
//
//  Created by Tatiana Lazarenko on 3/19/24.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet var mainImageView: UIImageView!
    
    private let networkManager = NetworkManager.shared
    var animeInfo: AnimeDataStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
   /* private func fetchImage() {
        let imageURL = URL(string: animeInfo.background)!
        networkManager.fetchImage(from: imageURL) { [unowned self] result in
            switch result {
            case .success(let imageData):
                mainImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }*/

}
