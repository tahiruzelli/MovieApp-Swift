//
//  WebServices.swift
//  MovieApp
//
//  Created by Tahir Uzelli on 8.04.2022.
//

import Foundation
class Webservices {
    
    func fetchNowPlayingMovies(url: URL, completion: @escaping ([NowPlayingModel]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                let nowPlayingMovies = try? JSONDecoder().decode(ApiResponse<[NowPlayingModel]>.self, from: data)
                
                if let nowPlayingMovies = nowPlayingMovies {
                    completion(nowPlayingMovies.results)
                }
                
            }
            
        }.resume()
        
    }

    func fetchUpcomingMovies(url: URL, completion: @escaping ([UpComing]?) -> ()) {

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                
            let upComingModel = try? JSONDecoder().decode(UpComingModel.self, from: data)
                if let upComingModel = upComingModel {
                    completion(upComingModel.results)
                }

            }

        }.resume()

    }
    
    func fetchMovieDetail(url: URL, completion: @escaping (MovieDetailModel?) -> ()) {

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                
            let movieDetail = try? JSONDecoder().decode(MovieDetailModel.self, from: data)
                if let movieDetail = movieDetail {
                    completion(movieDetail)
                }else{
                    print("error")
                }

            }

        }.resume()

    }
    
    func fetchSimilarMovies(url: URL, completion: @escaping ([SimilarMovies]?) -> ()) {

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                
            let similarMovies = try? JSONDecoder().decode(SimilarMoviesModel.self, from: data)
                if let similarMovies = similarMovies {
                    completion(similarMovies.results)
                }else{
                    print("error")
                }

            }

        }.resume()

    }
    
    func fetchSearchResults(url: URL, completion: @escaping ([SearchResult]?) -> ()) {

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
            let searchResult = try? JSONDecoder().decode(SearchResultModel.self, from: data)
                if let searchResult = searchResult {
                    completion(searchResult.results)
                }else{
                    print("error")
                    print(url.absoluteString)
                }

            }

        }.resume()

    }
}
