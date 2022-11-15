//
//  MovieReviewItem+CoreDataProperties.swift
//  CineJournal
//
//  Created by Laura Hernandez on 11/15/22.
//
//

import Foundation
import CoreData


extension MovieReviewItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieReviewItem> {
        return NSFetchRequest<MovieReviewItem>(entityName: "MovieReviewItem")
    }

    @NSManaged public var movieTitle: String?
    @NSManaged public var movieReview: String?
    @NSManaged public var movieScore: Int16
    @NSManaged public var moviePosterPath: String?
}

extension MovieReviewItem : Identifiable {

}
