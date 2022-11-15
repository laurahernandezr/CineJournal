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
    
    var movieReview: MovieReviewItem! {
        didSet{
                movieTitleLabel.text = movieReview.movieTitle
                reviewScoreLabel.text = String(movieReview.movieScore)
                reviewLabel.text = movieReview.movieReview
        }
    }
}
