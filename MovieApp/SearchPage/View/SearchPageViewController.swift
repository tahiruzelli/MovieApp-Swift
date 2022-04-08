//
//  SearchPageViewController.swift
//  MovieApp
//
//  Created by Tahir Uzelli on 8.04.2022.
//

import UIKit

class SearchPageViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var searchResultTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! SearchResultCell
        cell.movieName.text = "movie name"
        return cell
    }
    

    @IBOutlet weak var searhBarTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let myImage = UIImage(named: "search-icon"){
            searhBarTextField.withImage(direction: .Left, image: myImage)
        }
        searhBarTextField.clipsToBounds = true
        searhBarTextField.layer.cornerRadius = 10.0
        
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
        
    }
}
