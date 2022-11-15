//
//  MovieDetailViewController.swift
//  CineJournal
//
//  Created by Laura Hernandez on 11/15/22.
//
import UIKit

/// View controller for the movie detail screen.
class MovieDetailViewController: UIViewController {
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var backDropUIImageView: UIImageView!
    @IBOutlet weak var posterUIImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var userScoreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addReviewButton: UIButton!

    var posterPath = String()
    var backdropPath = String()
    var movieViewModel = MovieViewModel()
    let movieAPI = MovieAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movieViewModel.movie {
            movieTitleLabel.text = movie.movieTitle
            releaseDateLabel.text = movie.releaseDate
            userScoreLabel.text = String(format: "%.1f", movie.userScore ?? 0)
            descriptionLabel.text = movie.movieDescription
            posterPath = movie.posterPath ?? ""
            backdropPath = movie.backdropPath ?? ""
        }
        posterUIImageView.layer.cornerRadius = 20
        addReviewButton.layer.cornerRadius = 20
        addReviewButton.addTarget(self, action: #selector(addReviewButtonTapped), for: .touchUpInside)

        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w185\(posterPath)")
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780\(backdropPath)")


        movieAPI.fetchImage(url: posterUrl!) { data in
               if data != nil {
                   DispatchQueue.main.async {
                       self.posterUIImageView.image = UIImage(data: data!)
                       print("Image will be displayed")
                   }
               }
        }
        movieAPI.fetchImage(url: backdropUrl){
            data in
                   if data != nil {
                       DispatchQueue.main.async {
                           self.backDropUIImageView.image = UIImage(data: data!)
                           print("Image will be displayed")
                       }
                   }
        }
        
    }
    @objc func addReviewButtonTapped() {
        let movieReviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "MovieReviewViewController") as! MovieReviewViewController
        self.navigationController?.pushViewController(movieReviewViewController, animated: true)
    }
}
