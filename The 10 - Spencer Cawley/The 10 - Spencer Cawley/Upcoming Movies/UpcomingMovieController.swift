//
//  UpcomingMovieController.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/15/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit

class UpcomingMovieController: UITableViewController {
    
    // Properties
    let movieController = MovieController()
    let cellID = "upcomingMovieCell"
    let segueID = "toUpcomingDetailVC"

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUpcomingMovies()
    }
    
    // Fetch Upcoming Movies
    func fetchUpcomingMovies() {
        movieController.fetchUpcomingMovie { (movies) in
            guard movies != nil else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieController.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? UpcomingMovieCell else { return UITableViewCell() }
        let movie = movieController.movies[indexPath.row]
        cell.movie = movie
        
        // Fetch/Set images for each movie
        movieController.fetchMovieImage(movie: movie) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                cell.upcomingMovieImage.image = image
            }
        }
        return cell
    }

     //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID {
            guard let destinationVC = segue.destination as? MovieDetailController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.movie = movieController.movies[indexPath.row]
            destinationVC.hideTicketButton = true
        }
    }
}
