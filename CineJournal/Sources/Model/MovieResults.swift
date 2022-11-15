//
//  MovieResults.swift
//  CineJournal
//
//

import Foundation

/// Object that stores properties of the movie results we get back from the API.
struct MovieResults: Codable {
    let result: [Movie]

    enum CodingKeys: String, CodingKey {
        case result = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.result = try container.decode([Movie].self, forKey: .result)
    }
}
