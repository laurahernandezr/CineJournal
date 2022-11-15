//
//  MovieAPI.swift
//  CineJournal
//
//
import Foundation
/// Protocol that designates properties relevant to API endpoints.
protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var url: URL? { get }
}

/// API details for the Movie Database.
class MovieAPI: Endpoint {
    static let apiKey = "09e2ad35a571625f25a5246cd86eb8ed"

    // TODO: update return values for protocol properties

    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }

    var path: String {
        return "movie/550"
    }

    var url: URL? {
        return nil
    }
    
    func searchURL(withQuery query: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/search/movie"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: MovieAPI.apiKey),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "query", value: query)
        ]
        return components.url
    }
    
    static func nowPlayingURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/movie/now_playing"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: MovieAPI.apiKey)
        ]
        return components.url
    }
    
    func fetchNowPlaying(completion: @escaping (Result<[Movie], Error>) -> Void) {
        if let url = MovieAPI.nowPlayingURL() {
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
        if let url = searchURL(withQuery: text) {
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

