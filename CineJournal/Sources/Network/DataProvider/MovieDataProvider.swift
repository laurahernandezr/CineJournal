//
//  MovieDataProvider.swift
//  CineJournal
//
//

import Foundation

/// Movie data provider, responsible for setting up and kicking off requests to the API.
class MovieDataProvider {
    var movieAPI = MovieAPI()
    
    func fetchNowPlaying(completion: @escaping (Result<[Movie], Error>) -> Void) {
        if let url = movieAPI.nowPlayingURL() {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                if let data = data,
                   let moviesInfo = try? jsonDecoder.decode(MovieResults.self, from: data){
                    completion(.success(moviesInfo.result))
                }
            }
            task.resume()
        }
    }
    
    func fetchImage(url: URL?, completion: @escaping (Data?) -> Void) {
        if let url = url {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    completion(data)
                }
            }
            task.resume()
        }
    }
    
    func search(_ text: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        if let url = movieAPI.searchURL(withQuery: text) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                if let data = data,
                   let moviesInfo = try? jsonDecoder.decode(MovieResults.self, from: data){
                    completion(.success(moviesInfo.result))
                }
            }
            task.resume()
        }
    }
}

