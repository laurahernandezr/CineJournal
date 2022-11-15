//
//  MovieAPI.swift
//  CineJournal
//
//
import Foundation
/// Protocol that designates properties relevant to API endpoints.
protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
}

/// API details for the Movie Database.
class MovieAPI: Endpoint {
    static let apiKey = "09e2ad35a571625f25a5246cd86eb8ed"

    // TODO: update return values for protocol properties

    var scheme: String {
        return "https"
    }

    var host: String {
        return "api.themoviedb.org"
    }

    var searchPath: String {
        return "/3/search/movie"
    }
    
    var nowPlayingPath: String {
        return "/3/movie/now_playing"
    }
    
    func searchURL(withQuery query: String) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
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
    
    func nowPlayingURL() -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = "/3/movie/now_playing"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: MovieAPI.apiKey)
        ]
        return components.url
    }
    
   
}

