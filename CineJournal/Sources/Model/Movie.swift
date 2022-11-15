//
//  Movie.swift
//  CineJournal
//
//
//

import Foundation

/// Object that stores properties of an individual movie we get back from the API.
struct Movie: Codable {
    let movieTitle: String?
    let releaseDate: String?
    let userScore: Double?
    let posterPath: String?
    let backdropPath: String?
    let movieDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case movieTitle = "title"
        case releaseDate = "release_date"
        case userScore = "vote_average"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case movieDescription = "overview"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.movieTitle = try? container.decode(String.self, forKey: .movieTitle)
        self.releaseDate = try? container.decode(String.self, forKey: .releaseDate)
        self.userScore = try? container.decode(Double.self, forKey: .userScore)
        self.posterPath = try? container.decode(String.self, forKey: .posterPath)
        self.backdropPath = try? container.decodeIfPresent(String.self, forKey: .backdropPath)
        self.movieDescription = try? container.decode(String.self, forKey: .movieDescription)
    }
}

