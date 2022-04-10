//
//  MainPageViewModel.swift
//  MovieApp
//
//  Created by Tahir Uzelli on 10.04.2022.
//

import Foundation

class MainPageViewModel {
    var nowPlayingMovies: [NowPlaying]?
    var upComingList : [UpComing]?
    var selectedTableViewId : Int?
    var reloadTableViewClosure: (()->())?
    var reloadCollectionViewClosure: (()->())?
    
    var isUpComingMoviesLoading = true
    var isNowPlayingMoviesLoading = true
    
    func getUpComingMovies() {
        let url = URL(string: baseUrl + getUpcomingMoviesUrl + apiKey)!
         Webservices().fetchUpcomingMovies(url: url) { upComingMovies in
             
             if let upComingMovies = upComingMovies {
    
                 DispatchQueue.main.async { [self] in
                     self.upComingList = upComingMovies
                     reloadTableViewClosure!()
                     
                 }
             }
         }
    }
    
    func getNowPlayingMovies() {
        let url = URL(string: baseUrl + getNowPlayingMoviesUrl + apiKey)!
         Webservices().fetchNowPlayingMovies(url: url) { nowPlayingMovies in
             
             if let nowPlayingMovies = nowPlayingMovies {
    
                 DispatchQueue.main.async { [self] in
                     self.nowPlayingMovies = nowPlayingMovies
                     reloadCollectionViewClosure!()
                     
                 }
             }
         }
    }
    
    func getNowPlayingMovieTitle(index: Int) -> String {
            let row : NowPlaying = nowPlayingMovies![index]
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
