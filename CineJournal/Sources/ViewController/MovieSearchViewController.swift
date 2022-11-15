//
//  MovieSearchViewController.swift
//  CineJournal
//
import Foundation
import UIKit

class MovieSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var movieListUITableView: UITableView!
    @IBOutlet weak var movieSearchBar: UITextField!
    
    var moviewViewModels: [MovieViewModel] = Array()
    var movieDataProvider = MovieDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDataProvider.fetchNowPlaying(completion: nowPlayingCompletionHandler())
        movieListUITableView.delegate = self
        movieListUITableView.dataSource = self
        movieSearchBar.delegate = self
        movieSearchBar.addTarget(self, action: #selector(searchRecords(_:)), for: .editingChanged)
    }

    // MARK: Selectors
    
    @objc func searchRecords(_ textfield: UITextField) {
        self.moviewViewModels.removeAll()
        if textfield.text?.count != 0 {
            if  let movieToSearch = textfield.text {
                movieDataProvider.search(movieToSearch, completion: searchMovieCompletionHandler())
            }
        } else {
            movieDataProvider.fetchNowPlaying(completion: nowPlayingCompletionHandler())
        }
        movieListUITableView.reloadData()
    }
    
    // MARK: - Completion Handlers
    func searchMovieCompletionHandler() -> (Result<[Movie], Error>) -> Void {
        return { response in
            switch response {
            case .success(let movies):
                self.moviewViewModels = movies.map({return MovieViewModel(movie: $0)})
                DispatchQueue.main.async {
                    self.movieListUITableView.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func nowPlayingCompletionHandler() -> (Result<[Movie], Error>) -> Void {
        return { response in
            switch response {
            case .success(let movies):
                self.moviewViewModels = movies.map({return MovieViewModel(movie: $0)})
                DispatchQueue.main.async {
                    self.movieListUITableView.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        movieSearchBar.resignFirstResponder()
        return true
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviewViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieResultsTableViewCell") as! MovieResultsTableViewCell
        let movieViewModel = moviewViewModels[indexPath.row]
        cell.movieViewModel = movieViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        detailsVC.movieViewModel = moviewViewModels[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}


