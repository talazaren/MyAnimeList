//
//  MainViewController.swift
//  MyAnimeList
//
//  Created by Tatiana Lazarenko on 3/15/24.
//

import UIKit

final class MainViewController: UICollectionViewController {

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    private var descriptions: [AnimeDataStore] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        fetchAnimeDescriptions()
    }

    private func fetchAnimeDescriptions() {
        let animeAPILink = URL(string: "https://api.jikan.moe/v4/anime")!
        
        URLSession.shared.dataTask(with: animeAPILink) { [unowned self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(AnimeDescription.self, from: data)
                descriptions = response.data
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
        descriptions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath)
        guard let cell = cell as? CustomCell else { return UICollectionViewCell() }
        
        let titles = descriptions[indexPath.item].titles
        var titleLabel = ""
        titles.forEach { title in
            if title.type == "Default" {
                titleLabel = title.title
            }
        }
        cell.animeTitleLabel.text = titleLabel
        
        let imageSource = descriptions[indexPath.item].images.jpg.image_url
        let imageURL = URL(string: imageSource)!
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            DispatchQueue.main.async {
                cell.animeImageView.image = UIImage(data: data)
            }
        }.resume()
        
        
        let genres = descriptions[indexPath.item].genres
        var genreLabel = ""
        genres.forEach { genre in
            genreLabel += "\(genre.name) "
        }
        cell.animeGenresLabel.text = genreLabel
        
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
