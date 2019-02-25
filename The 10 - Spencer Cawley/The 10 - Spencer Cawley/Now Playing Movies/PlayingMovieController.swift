//
//  MovieTableViewController.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/13/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit

class PlayingMovieController: UITableViewController {
    
    //Properties
    let movieController = MovieController()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPlayingMovies()
        setCustomBackButton()
    }
    
    // Fetch Currently Playing Movies
    func fetchPlayingMovies() {
        movieController.fetchPlayingMovie { (movies) in
            guard movies != nil else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // Eliminate text from back button on NavBar
    func setCustomBackButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieController.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "playingMovieCell", for: indexPath) as? PlayingMovieCell else { return UITableViewCell() }
        let movie = movieController.movies[indexPath.row]
        cell.movie = movie
        
        // Fetch/Set images for each movie
        movieController.fetchMovieImage(movie: movie) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                cell.playingMovieImage.image = image
            }
        }
        return cell
    }
    
     //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlayingDetailVC" {
            guard let destinationVC = segue.destination as? MovieDetailController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.movie = movieController.movies[indexPath.row]
        }
    }
}

