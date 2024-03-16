//
//  MainViewController.swift
//  MyAnimeList
//
//  Created by Tatiana Lazarenko on 3/15/24.
//

import UIKit

final class MainViewController: UICollectionViewController {

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private let animeAPILink = URL(string: "https://api.jikan.moe/v4/anime")!
    private var descriptions: AnimeDescription?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        fetchAnimeDescriptions()
        
    }

    private func fetchAnimeDescriptions() {
        URLSession.shared.dataTask(with: animeAPILink) { [unowned self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                descriptions = try JSONDecoder().decode(AnimeDescription.self, from: data)
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
            }
        }.resume()
    }


    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return descriptions?.data.count ?? 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath)
        guard let cell = cell as? CustomCell else { return UICollectionViewCell() }
        
        let titles = descriptions?.data[indexPath.item].titles ?? []
        var titleLabel = ""
        
        titles.forEach { title in
            if title.type == "Default" {
                titleLabel = title.title
            }
        }
        cell.animeTitleLabel.text = titleLabel
        
        let imageURL = descriptions?.data[indexPath.item].images.jpg.image_url ?? "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
        cell.animeImageView.image = UIImage(contentsOfFile: imageURL)
        
        return cell
    }
    
    

}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width - 100
        let itemWidth = collectionViewWidth / 2
        let itemHeight = itemWidth + 60
            
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
