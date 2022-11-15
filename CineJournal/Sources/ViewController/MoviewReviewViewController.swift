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
//    var movieTitle = String()
    override func viewDidLoad() {
        super.viewDidLoad()
//        movieTitleLabel.text = movieTitle
        reviewUITextView.layer.cornerRadius = 20
        addToJournalButton.addTarget(self, action: #selector(addToJournalButtonPressed), for: .touchUpInside)
    }
    @objc func addToJournalButtonPressed() {
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "JournalViewController") as! JournalViewController
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
