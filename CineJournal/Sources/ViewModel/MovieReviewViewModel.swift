//
//  MovieReviewViewModel.swift
//  CineJournal
//
//

import Foundation

struct MovieReviewViewModel {
    let movieReview: MovieReviewItem?
    
    init(movieReview: MovieReviewItem) {
        self.movieReview = movieReview
    }
    
    init() {
        self.movieReview = nil
    }
}
