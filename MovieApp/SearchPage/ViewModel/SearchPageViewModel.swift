//
//  SearchPageViewModel.swift
//  MovieApp
//
//  Created by Tahir Uzelli on 10.04.2022.
//

import Foundation

class SearchPageViewModel {
    var searchResults : [SearchResult]?
    var textFieldString : String = ""
    var reloadTableViewClosure: (()->())?
    
    func getSearchResults(){
        let urlString : String = baseUrl + getSearchResultsUrl + apiKey + "&query=" + textFieldString
        let url = URL(string: urlString)!

         Webservices().fetchSearchResults(url: url) { searchResults in
             if let searchResults = searchResults {
                 DispatchQueue.main.async { [self] in
                     self.searchResults = searchResults
                     reloadTableViewClosure!()
                 }
             }
         }
    }
    
    func fillTableViewCell(index : Int) -> String{
        let row : SearchResult = searchResults![index]
        let releaseDate : String?
        if(row.releaseDate == nil || row.releaseDate == ""){
            releaseDate = "(Unknown)"
        }
        else{
            releaseDate = "(" + String(row.releaseDate?.split(separator: "-")[0] ?? "") + ")"
        }
        return row.title! + " " + (releaseDate ?? "")
    }
    
}
