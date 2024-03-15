//
//  MainViewController.swift
//  MyAnimeList
//
//  Created by Tatiana Lazarenko on 3/15/24.
//

import UIKit

final class MainViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath)
        guard let cell = cell as? CustomCell else { return UICollectionViewCell() }
                
        // Configure the cell
    
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
