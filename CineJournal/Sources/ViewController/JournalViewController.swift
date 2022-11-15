//
//  JournalViewController.swift
//  CineJournal
//
//  Created by Laura Hernandez on 11/15/22.
//

import Foundation
import UIKit

class JournalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var journalTableView: UITableView!
    
    var movieReviews = [MovieReviewItem]()
    var movieDataProvider = MovieDataProvider()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        journalTableView.delegate = self
        journalTableView.dataSource = self
        getAllItems()
    }
    
    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalEntryTableViewCell") as! JournalEntryTableViewCell
        let movieReview = movieReviews[indexPath.row]
        cell.movieReview = movieReview
        fetchCellImages(cell: cell)
        return cell
    }
    
    // MARK: Private
    func fetchCellImages(cell: JournalEntryTableViewCell) -> Void {
        if let moviePosterPath = cell.movieReview.moviePosterPath {
            let posterUrl = URL(string: "https://image.tmdb.org/t/p/w185\(moviePosterPath)")
            movieDataProvider.fetchImage(url: posterUrl!) { data in
                   if data != nil {
                       DispatchQueue.main.async {
                           cell.moviePosterUIImageView.image = UIImage(data: data!)
                       }
                   }
            }
        }
       
    }
    
    // MARK: MovieReviewItem - CoreData
    
     func getAllItems() {
        do {
            movieReviews = try context.fetch(MovieReviewItem.fetchRequest())
        }
        catch {
            print("Movie reviews could not be retrieved")
        }
    }
    
     func createItem(title: String, score: Int, review: String, posterPath: String) {
        let newItem = MovieReviewItem(context: context)
        newItem.movieTitle = title
        newItem.movieScore = Int16(score)
        newItem.movieReview = review
        newItem.moviePosterPath = posterPath
        do {
            try context.save()
            getAllItems()
        } catch {
            print("Movie review could not be added")
        }
        
    }
    
     func deleteItem(item: MovieReviewItem) {
        context.delete(item)
        do {
            try context.save()
        } catch {
            print("Movie review could not be added")
        }
        
    }
}
