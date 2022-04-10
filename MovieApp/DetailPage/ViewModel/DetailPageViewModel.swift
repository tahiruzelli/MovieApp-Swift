//
//  DetailPageViewModel.swift
//  MovieApp
//
//  Created by Tahir Uzelli on 10.04.2022.
//

import Foundation

class DetailPageViewModel {
    
    var movieId : Int?
    var movieDetail : MovieDetailModel?
    var similarMovies : [SimilarMovies]?
    
    var reloadTableViewClosure: (()->())?
    var reloadMovieDetail: (()->())?
    
    func getMovieDetail() {
        if(movieId != nil){
            let url = URL(string: baseUrl + getMovieDetailUrl + String(movieId ?? 0) + apiKey)!
             Webservices().fetchMovieDetail(url: url) { movieDetail in
                 
                 if let movieDetail = movieDetail {
        
                     DispatchQueue.main.async { [self] in
                         self.movieDetail = movieDetail
                         reloadMovieDetail!()        
                     }
                 }
             }
        }
        
    }
    
    func getSimilarMovies() {
        let url = URL(string: baseUrl + getMovieDetailUrl + String(movieId ?? 0) + "/similar" + apiKey)!
         Webservices().fetchSimilarMovies(url: url) { similarMovies in
             
             if let similarMovies = similarMovies {
    
                 DispatchQueue.main.async { [self] in
                     self.similarMovies = similarMovies
                     reloadTableViewClosure!()
                 }
             }
         }
    }
}
