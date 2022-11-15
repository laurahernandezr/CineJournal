//
//  MovieResultsTableViewCell.swift
//  CineJournal
//
//

import UIKit

class MovieResultsTableViewCell: UITableViewCell {
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    var movieViewModel: MovieViewModel! {
        didSet{
            if let movie = movieViewModel.movie {
                movieTitleLabel.text = movie.movieTitle
            }
        }
    }

}
