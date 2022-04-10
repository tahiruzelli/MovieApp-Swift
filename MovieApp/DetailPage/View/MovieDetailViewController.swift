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
    
    lazy var viewModel: DetailPageViewModel = {
        return DetailPageViewModel()
    }()

    func initVM(){
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        viewModel.reloadMovieDetail = { [weak self] () in
            DispatchQueue.main.async {
                self!.movieName.text = self!.viewModel.movieDetail?.title
                self!.movieName.text = self!.viewModel.movieDetail?.title
                self!.movieDesc.text = self!.viewModel.movieDetail?.overview
                self!.movieImage.downloaded(from: imageBaseUrl + self!.viewModel.movieDetail!.backdropPath!)
                self!.movieRate.text = String(self!.viewModel.movieDetail?.voteAverage ?? 0)
                self!.movieReleaseDate.text = self!.viewModel.movieDetail?.releaseDate
            }
        }

        
        viewModel.getMovieDetail()
        viewModel.getSimilarMovies()
    }
    func initView(){
        movieImage.contentMode = .scaleAspectFill
    }
    


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initVM()

    }
}

extension MovieDetailViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.similarMovies?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMoviesCell.identifier, for: indexPath) as! SimilarMoviesCell
        let row = self.viewModel.similarMovies?[indexPath.row]
        cell.coverImage.downloaded(from: imageBaseUrl + row!.posterPath)
        cell.movieTitle.text = row?.title
        return cell
    }
}
