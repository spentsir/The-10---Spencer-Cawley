//
//  MovieController.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/13/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit

// Container for Cached Images
var imageCache = [String: UIImage]()

class MovieController {
    
    // Properties
    var movies = [Movie]()
    
    // Base URL Strings
    let playingBaseURL = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=725427eb27bb2372e7c69e11e5256f55")
    let upcomingBaseURL = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=725427eb27bb2372e7c69e11e5256f55&language=en-US&page=2")
    
    // Fetch Current Movies Playing
    func fetchPlayingMovie(completion: @escaping([Movie]?) -> Void) {
        let url = playingBaseURL!
    
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let decodedData = try jsonDecoder.decode(JSONDictionary.self, from: data)
                    let movies = decodedData.results.compactMap( { $0})
                    
                    // Throw movies into moviesArray to pull a specific number of movies (10 movies)
                    let moviesArray = Array(movies.prefix(through: 9))
                    self.movies = moviesArray
                    completion(moviesArray)
                    
                } catch {
                    print("Error!: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                if let error = error {
                    print("Error!: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
            }
        }
        dataTask.resume()
    }
    
    // Fetch Upcoming Movies
    func fetchUpcomingMovie(completion: @escaping([Movie]?) -> Void) {
        let url = upcomingBaseURL!
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let decodedData = try jsonDecoder.decode(JSONDictionary.self, from: data)
                    let movies = decodedData.results.compactMap( { $0})
                    
                    // Throw movies into moviesArray to pull a specific number of movies (10 movies)
                    let moviesArray = Array(movies.prefix(through: 9))
                    self.movies = moviesArray
                    completion(moviesArray)
                    
                } catch {
                    print("Error!: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                if let error = error {
                    print("Error!: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
            }
        }
        dataTask.resume()
    }
    
    
    // Fetch Movie Poster Images
    func fetchMovieImage(movie: Movie, completion: @escaping(UIImage?) -> Void) {
        guard let posterPath = movie.posterPath else { completion(nil); return }
        
        // Check if image has been cached, if so use the cached image
        if let cachedImage = imageCache[posterPath] {
            completion(cachedImage)
            return
        }
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500")!.appendingPathComponent(posterPath)
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data {
                let image = UIImage(data: data)
                
                // save image to cache container
                imageCache[url.absoluteString] = image
                completion(image)
            }
            if let error = error {
                print("Error!: \(error.localizedDescription)")
                completion(nil)
                return
            }
        }
        dataTask.resume()
    }
}
