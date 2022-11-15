//
//  MovieViewModel.swift
//  CineJournal
//
//

import Foundation

struct MovieViewModel {
    let movie: Movie?
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    init() {
        self.movie = nil
    }
}
