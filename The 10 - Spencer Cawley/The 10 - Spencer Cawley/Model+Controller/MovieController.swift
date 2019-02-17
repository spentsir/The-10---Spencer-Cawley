//
//  MovieController.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/13/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit

class MovieController {
    
    var movies = [Movie]()
    let playingBaseURL = URL(string: "https://api.themoviedb.org/3/movie/now_playing")!
    let upcomingBaseURL = URL(string: "https://api.themoviedb.org/3/movie/upcoming")!
    
    func fetchPlayingMovie(completion: @escaping([Movie]?) -> Void) {
        
        let queries = [
            "total_results" : "10",
            "api_key" : "725427eb27bb2372e7c69e11e5256f55"
        ]
        
        let url = playingBaseURL.withQueries(queries)!
        print(url)
    
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let decodedData = try jsonDecoder.decode(JSONDictionary.self, from: data)
                    let movies = decodedData.results.compactMap( { $0})
                    
                    self.movies = movies
                    completion(movies)
                    print(movies.count)
                    
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
    
    func fetchUpcomingMovie(completion: @escaping([Movie]?) -> Void) {
        
        let queries = [
            "total_results" : "10",
            "api_key" : "725427eb27bb2372e7c69e11e5256f55"
        ]
        
        let url = upcomingBaseURL.withQueries(queries)!
        print(url)
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let decodedData = try jsonDecoder.decode(JSONDictionary.self, from: data)
                    let movies = decodedData.results.compactMap( { $0})
                    
                    self.movies = movies
                    completion(movies)
                    print(movies.count)
                    
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
    
    func fetchMovieImage(movie: Movie, completion: @escaping(UIImage?) -> Void) {
        guard let posterPath = movie.posterPath else { completion(nil); return }
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500")!.appendingPathComponent(posterPath)
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data {
                let image = UIImage(data: data)
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
