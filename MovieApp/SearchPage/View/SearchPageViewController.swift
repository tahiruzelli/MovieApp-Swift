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
    @IBOutlet weak var searhBarTextField: UITextField!
    
    lazy var viewModel: SearchPageViewModel = {
        return SearchPageViewModel()
    }()
    
    
    func initVM(){
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.searchResultTableView.reloadData()
            }
        }
    }
    func initView(){
        if let myImage = UIImage(named: "search-icon"){
            searhBarTextField.withImage(direction: .Left, image: myImage)
        }
        searhBarTextField.clipsToBounds = true
        searhBarTextField.layer.cornerRadius = 10.0
        
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
        searhBarTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! SearchResultCell
        cell.movieName.text = viewModel.fillTableViewCell(index: indexPath.row)
        return cell
    }
    

 
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initVM()
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        viewModel.textFieldString = searhBarTextField.text!
        viewModel.getSearchResults()

    }
}
