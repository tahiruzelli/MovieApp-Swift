//
//  MainPageViewController.swift
//  MovieApp
//
//  Created by Tahir Uzelli on 8.04.2022.
//

import UIKit
import ImageSlideshow
import NVActivityIndicatorView

class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var activityIndicator : NVActivityIndicatorView!
    @IBOutlet weak var imageSliderCollectionView: UICollectionView!
    @IBOutlet weak var MoviesTableView: UITableView!
    @IBOutlet weak var searchBarTextField: UITextField!
    
    var currentIndex : Int = 0
    var timer : Timer?
    
    lazy var viewModel: MainPageViewModel = {
        return MainPageViewModel()
    }()
    
    func initVM(){
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.MoviesTableView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
        viewModel.reloadCollectionViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.imageSliderCollectionView.reloadData()
            }
        }
        viewModel.getUpComingMovies()
        viewModel.getNowPlayingMovies()
    }
    func initView(){
        let xAxis = self.view.center.x
        let yAxis = self.view.center.y
        let frame = CGRect(x: (xAxis - 22.5), y: (yAxis - 45), width: 45, height: 45)
        activityIndicator = NVActivityIndicatorView(frame: frame)
        activityIndicator.type = .ballTrianglePath
        activityIndicator.color = UIColor.red

        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        if let myImage = UIImage(named: "search-icon"){
            searchBarTextField.withImage(direction: .Right, image: myImage)
        }
        searchBarTextField.clipsToBounds = true
        searchBarTextField.layer.cornerRadius = 10.0
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onSearchBarPressed))
        searchBarTextField.isUserInteractionEnabled = true
        searchBarTextField.addGestureRecognizer(gestureRecognizer)
        
        MoviesTableView.dataSource = self
        MoviesTableView.delegate = self

    }
    
    private func startTime(){
            self.timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(autoSliderCell), userInfo: nil, repeats: true)
    }
    
    @objc func autoSliderCell(){
        if currentIndex < (viewModel.nowPlayingMovies?.count ?? 0) - 1 {
            self.currentIndex += 1
        }else{
            currentIndex = 0
        }
        self.imageSliderCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.upComingList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        let row : UpComing = viewModel.upComingList![indexPath.row]
        cell.movieName.text = row.title
        cell.movieDesc.text = row.overview
        cell.movieDate.text = row.releaseDate
        cell.movieImage.downloaded(from: imageBaseUrl + row.posterPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedTableViewId = viewModel.upComingList![indexPath.row].id
            performSegue(withIdentifier: "toMovieDetail2", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMovieDetail2" {
            let destinationVC = segue.destination as! MovieDetailViewController
            destinationVC.viewModel.movieId = viewModel.selectedTableViewId
        }
    }
    
    @objc func onSearchBarPressed(){
        performSegue(withIdentifier: "toSearchPage", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initVM()
        startTime()
        
    }

}

extension MainPageViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.nowPlayingMovies?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingMovieCell.identifier, for: indexPath) as! NowPlayingMovieCell
        
        cell.set(title: viewModel.getNowPlayingMovieTitle(index: indexPath.row), overview: viewModel.nowPlayingMovies![indexPath.row].overview ?? "", image: viewModel.nowPlayingMovies![indexPath.row].posterPath!)
 return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}


