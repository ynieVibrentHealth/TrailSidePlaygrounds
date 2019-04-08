//
//  FavoriteMovieCoreDataHelper.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation
import CoreData

class FavoriteMovieCoreDataHelper {
    static let instance:FavoriteMovieCoreDataHelper = FavoriteMovieCoreDataHelper()
    private init(){}
    
    private var movieItemRC:NSFetchedResultsController<FavoriteMovie>!
    
    func saveFavoriteMovie(movieViewModel:MovieSearchViewModel, completion:((_ success:Bool) -> Void)) {
        let context = AppDelegate.appDelegate.persistentContainer.viewContext
        let favoriteMovie = FavoriteMovie(context: context)
        
        favoriteMovie.title = movieViewModel.title
        favoriteMovie.director = movieViewModel.director
        favoriteMovie.id = movieViewModel.id
        favoriteMovie.movieDescription = movieViewModel.description
        favoriteMovie.contentInformation = movieViewModel.contentInformation
        favoriteMovie.imageURL = movieViewModel.imageURLString
        favoriteMovie.year = movieViewModel.year
        favoriteMovie.rentHD = movieViewModel.rentHD
        favoriteMovie.rentSD = movieViewModel.rentSD
        favoriteMovie.buyHD = movieViewModel.buyHD
        favoriteMovie.buySD = movieViewModel.buySD
        
        guard let _ = try? context.save() else {completion(false);return}
        completion(true)
    }
    
    private func fetchAllFavoritedMovies() -> [FavoriteMovie]?{
        let context = AppDelegate.appDelegate.persistentContainer.viewContext
        let request = FavoriteMovie.fetchRequest() as NSFetchRequest<FavoriteMovie>
        let sort = NSSortDescriptor(key: #keyPath(FavoriteMovie.id), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
        request.sortDescriptors = [sort]
        do {
            movieItemRC = NSFetchedResultsController(fetchRequest: request,
                                                     managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            try movieItemRC.performFetch()
            return movieItemRC.fetchedObjects
        } catch let error as NSError {
            print("Unable to fetch \(error)")
            return nil
        }
    }
    
    internal func getFavoritedMovie(from movieId:String) -> [FavoriteMovie]?{
        let context = AppDelegate.appDelegate.persistentContainer.viewContext
        let request = FavoriteMovie.fetchRequest() as NSFetchRequest<FavoriteMovie>
        let sort = NSSortDescriptor(key: #keyPath(FavoriteMovie.id), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
        request.sortDescriptors = [sort]
        request.predicate = NSPredicate(format: "id = %@", movieId)
        do {
            movieItemRC = NSFetchedResultsController(fetchRequest: request,
                                                     managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            try movieItemRC.performFetch()
            return movieItemRC.fetchedObjects
        } catch let error as NSError {
            print("Unable to fetch \(error)")
            return nil
        }
    }
    
    public func loadAllFavoriteMovies() -> [MovieSearchViewModel] {
        guard let movies = fetchAllFavoritedMovies() else {return []}
        let movieViewModel = movies.map { (movieModel) -> MovieSearchViewModel? in
            guard let title:String = movieModel.title,
                let director:String = movieModel.director,
                let year:String = movieModel.year,
                let description:String = movieModel.movieDescription,
                let imageURLString:String = movieModel.imageURL,
                let id:String = movieModel.id,
                let contentInformation:String = movieModel.contentInformation,
                let rentHD:String = movieModel.rentHD,
                let rentSD:String = movieModel.rentSD,
                let buyHD:String = movieModel.buyHD,
                let buySD:String = movieModel.buySD else {return nil}
            return MovieSearchViewModel(title: title, director: director, year: year, description: description, imageURLString: imageURLString, trackId: id, contentInformation: contentInformation, isFavorite: true, rentHD: rentHD, rentSD: rentSD, buyHD: buyHD, buySD: buySD)
        }.compactMap({$0})
        return movieViewModel
    }
}
