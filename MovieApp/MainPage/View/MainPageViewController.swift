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
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
          print("current page:", page)
      }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        cell.movieName.text = "forest gump"
        cell.movieDesc.text = "run forest run"
        cell.movieDate.text = "1997"
        cell.movieImage.downloaded(from: "https://www.chip.com.tr/images/content/2020/09/25/20200925140142692119.jpg")
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onCellPressed))
        cell.isUserInteractionEnabled = true
        cell.addGestureRecognizer(gestureRecognizer)
        return cell
    }
    
    @objc func onCellPressed(){
        print("cell pressed")
    }
    @objc func onSearchBarPressed(){
        performSegue(withIdentifier: "toSearchPage", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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


        
        slideShow.slideshowInterval = 5.0
        slideShow.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)
        slideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        slideShow.pageIndicator = pageControl
        slideShow.activityIndicator = DefaultActivityIndicator()
        slideShow.delegate = self
        slideShow.setImageInputs([
        ImageSource(image: UIImage(named: "1")!),
          ImageSource(image: UIImage(named: "2")!),
          ImageSource(image: UIImage(named: "3")!),
          ImageSource(image: UIImage(named: "4")!),
          ImageSource(image: UIImage(named: "5")!),
        ])

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        slideShow.addGestureRecognizer(recognizer)
    }

    @objc func didTap() {
        let fullScreenController = slideShow.presentFullScreenController(from: self)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: UIActivityIndicatorView.Style.medium, color: nil)
    }
}

