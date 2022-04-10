//
//  MainPageViewController.swift
//  MovieApp
//
//  Created by Tahir Uzelli on 8.04.2022.
//

import UIKit
import ImageSlideshow

class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ImageSlideshowDelegate {
    
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var MoviesTableView: UITableView!
    @IBOutlet weak var searchBarTextField: UITextField!
    
    lazy var viewModel: MainPageViewModel = {
        return MainPageViewModel()
    }()
    
    func initVM(){
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.MoviesTableView.reloadData()
            }
        }
        viewModel.getUpComingMovies()
        viewModel.getNowPlayingMovies()
    }
    func initView(){
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

        slideShow.delegate = self
        slideShow.setImageInputs([
            ImageSource(image: UIImage(named: "1")!),
            ImageSource(image: UIImage(named: "2")!),
            ImageSource(image: UIImage(named: "3")!),
            ImageSource(image: UIImage(named: "4")!),
            ImageSource(image: UIImage(named: "5")!),
        ])
        
        slideShow.slideshowInterval = 5.0
        slideShow.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
        slideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        slideShow.pageIndicator = pageControl
        slideShow.activityIndicator = DefaultActivityIndicator()

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        slideShow.addGestureRecognizer(recognizer)
    }
    

    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
          print("current page:", page)
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
        
    }

    @objc func didTap() {
        let fullScreenController = slideShow.presentFullScreenController(from: self)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: UIActivityIndicatorView.Style.medium, color: nil)
    }
}

