//
//  SearchPageViewController.swift
//  MovieApp
//
//  Created by Tahir Uzelli on 8.04.2022.
//

import UIKit

class SearchPageViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    var searchResults : [SearchResult]?
    func getSearchResults(){
        let urlString : String = baseUrl + getSearchResultsUrl + apiKey + "&query=" + searchTextField.text!
        let url = URL(string: urlString)!

         Webservices().fetchSearchResults(url: url) { searchResults in

             if let searchResults = searchResults {

                 DispatchQueue.main.async { [self] in
                     self.searchResults = searchResults
                     searchResultTableView.reloadData()
                 }
             }
         }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! SearchResultCell
        let row = searchResults![indexPath.row]
        let releaseDate : String?
        if(row.releaseDate == nil || row.releaseDate == ""){
            releaseDate = "(Unknown)"
        }
        else{
            releaseDate = "(" + String(row.releaseDate?.split(separator: "-")[0] ?? "") + ")"
        }
        
        cell.movieName.text = row.title! + " " + (releaseDate ?? "")
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
        searhBarTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        getSearchResults()
    }
}
