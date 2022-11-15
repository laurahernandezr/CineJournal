//
//  JournalEntryTableViewCell.swift
//  CineJournal
//
//  Created by Laura Hernandez on 11/15/22.
//

import UIKit

class JournalEntryTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var reviewScoreLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var moviePosterUIImageView: UIImageView!
    
    var movieViewModel: MovieViewModel! {
        didSet{
            if let movie = movieViewModel.movie {
                movieTitleLabel.text = movie.movieTitle
//                reviewScoreLabel.text =
            }
        }
    }
}
