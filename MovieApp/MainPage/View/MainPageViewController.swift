//
//  MainPageViewController.swift
//  MovieApp
//
//  Created by Tahir Uzelli on 8.04.2022.
//

import UIKit

class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
    @IBOutlet weak var MoviesTableView: UITableView!
    @IBOutlet weak var searchBarTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let myImage = UIImage(named: "search-icon"){
            searchBarTextField.withImage(direction: .Right, image: myImage)
        }
        searchBarTextField.clipsToBounds = true
        searchBarTextField.layer.cornerRadius = 10.0
        MoviesTableView.delegate = self
        MoviesTableView.dataSource = self
        
    }
}
