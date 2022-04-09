//
//  MainPageViewController.swift
//  MovieApp
//
//  Created by Tahir Uzelli on 8.04.2022.
//

import UIKit
import ImageSlideshow

class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ImageSlideshowDelegate {
    private var nowPlayingMovies: NowPlayingModel!
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var MoviesTableView: UITableView!
    @IBOutlet weak var searchBarTextField: UITextField!
    
    var upComingList : [UpComing]?
    
    private func getData() {
        let url = URL(string: baseUrl + getUpcomingMoviesUrl + apiKey)!
        print(baseUrl + getUpcomingMoviesUrl + apiKey)
         Webservices().fetchUpcomingMovies(url: url) { nowPlayingMovies in
             
             if let nowPlayingMovies = nowPlayingMovies {
    
                 DispatchQueue.main.async { [self] in
                     self.upComingList = nowPlayingMovies
                     MoviesTableView.reloadData()
         
                 }
             }
         }
        
    }
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
          print("current page:", page)
      }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upComingList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        let row : UpComing = upComingList![indexPath.row]
        cell.movieName.text = row.title
        cell.movieDesc.text = row.overview
        cell.movieDate.text = row.releaseDate
        cell.movieImage.downloaded(from: imageBaseUrl + row.posterPath)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onCellPressed))
        cell.isUserInteractionEnabled = true
        cell.addGestureRecognizer(gestureRecognizer)
        return cell
    }
    
    @objc func onCellPressed(){
        performSegue(withIdentifier: "toMovieDetail", sender: nil)
    }
    @objc func onSearchBarPressed(){
        performSegue(withIdentifier: "toSearchPage", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
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

    @objc func didTap() {
        let fullScreenController = slideShow.presentFullScreenController(from: self)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: UIActivityIndicatorView.Style.medium, color: nil)
    }
}

