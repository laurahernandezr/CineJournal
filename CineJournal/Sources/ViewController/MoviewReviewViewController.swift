//
//  MoviewReviewViewController.swift
//  CineJournal
//
//

import Foundation
import UIKit

class MovieReviewViewController: UIViewController {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var scoreUIControl: UISegmentedControl!
    @IBOutlet weak var addToJournalButton: UIButton!
    @IBOutlet weak var reviewUITextView: UITextView!
    
    var movieViewModel = MovieViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitleLabel.text = movieViewModel.movie?.movieTitle
        reviewUITextView.layer.cornerRadius = 20
        reviewUITextView.text = nil
        addToJournalButton.addTarget(self, action: #selector(addToJournalButtonPressed), for: .touchUpInside)
    }
    
    // MARK: Selectors
    @objc func addToJournalButtonPressed() {
        let journalViewController = self.storyboard?.instantiateViewController(withIdentifier: "JournalViewController") as! JournalViewController
        if let movieTitle = self.movieViewModel.movie?.movieTitle,
           let posterPath = self.movieViewModel.movie?.posterPath {
            journalViewController.createItem(title: movieTitle, score: scoreUIControl.selectedSegmentIndex, review: reviewUITextView.text, posterPath: posterPath)
        }
        self.navigationController?.pushViewController(journalViewController, animated: true)
    }
}
