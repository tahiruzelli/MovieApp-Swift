//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Tahir Uzelli on 8.04.2022.
//

import UIKit

class MovieDetailViewController: UIViewController{
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDesc: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var isLoading = true
    var movieId : Int?
    var movieDetail : MovieDetailModel?
    var similarMovies : [SimilarMovies]?
    private func getMovieDetail() {
        let url = URL(string: baseUrl + getMovieDetailUrl + String(movieId ?? 0) + apiKey)!
         Webservices().fetchMovieDetail(url: url) { movieDetail in
             
             if let movieDetail = movieDetail {
    
                 DispatchQueue.main.async { [self] in
                     self.movieDetail = movieDetail
                     movieName.text = self.movieDetail?.title
                     movieDesc.text = self.movieDetail?.overview
                     movieImage.downloaded(from: imageBaseUrl + self.movieDetail!.backdropPath!)
                     movieRate.text = String(self.movieDetail?.voteAverage ?? 0)
                     movieReleaseDate.text = self.movieDetail?.releaseDate
                     isLoading = false
                     
                 }
             }
         }
        
    }
    
    private func getSimilarMovies() {
        let url = URL(string: baseUrl + getMovieDetailUrl + String(movieId ?? 0) + "/similar" + apiKey)!
        print(baseUrl + getMovieDetailUrl + String(movieId ?? 0) + "/similar" + apiKey)
         Webservices().fetchSimilarMovies(url: url) { similarMovies in
             
             if let similarMovies = similarMovies {
    
                 DispatchQueue.main.async { [self] in
                     self.similarMovies = similarMovies
                     collectionView.reloadData()
                 }
             }
         }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieDetail()
        getSimilarMovies()
    }
}

extension MovieDetailViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.similarMovies?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMoviesCell.identifier, for: indexPath) as! SimilarMoviesCell
        let row = self.similarMovies?[indexPath.row]
        cell.coverImage.downloaded(from: imageBaseUrl + row!.posterPath)
        cell.movieTitle.text = row?.title
        return cell
    }
}
