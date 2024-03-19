//
//  MainViewController.swift
//  MyAnimeList
//
//  Created by Tatiana Lazarenko on 3/15/24.
//

import UIKit

final class MainViewController: UICollectionViewController {

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private let networkManager = NetworkManager.shared
    private var descriptions: [AnimeDataStore] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        fetchAnimeDescriptions()
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        descriptions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath)
        guard let cell = cell as? CustomCell else { return UICollectionViewCell() }
        
        let description = descriptions[indexPath.item]
        cell.configure(with: description)
        
        return cell
    }
    
    private func fetchAnimeDescriptions() {
        networkManager.fetch(from: Link.myAnimeListURL.url) { [unowned self] result in
            switch result {
            case .success(let animeData):
                descriptions = animeData.data
                activityIndicator.stopAnimating()
                collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
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
