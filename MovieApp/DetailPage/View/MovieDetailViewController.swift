//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Tahir Uzelli on 8.04.2022.
//

import UIKit

class MovieDetailViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MovieDetailViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMoviesCell.identifier, for: indexPath) as! SimilarMoviesCell
                return cell
    }
}
