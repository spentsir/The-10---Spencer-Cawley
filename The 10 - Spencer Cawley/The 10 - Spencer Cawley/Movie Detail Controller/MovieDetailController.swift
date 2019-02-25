//
//  MovieDetailViewController.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/13/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit
import SafariServices

class MovieDetailController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var playingMovieDetailImage: UIImageView!
    @IBOutlet weak var playingMovieDetailRating: UILabel!
    @IBOutlet weak var outOf10: UILabel!
    @IBOutlet weak var playingMovieDetailOverview: UILabel!
    @IBOutlet weak var playingMovieID: UILabel!
    @IBOutlet weak var playTrailerButton: UIButton!
    @IBOutlet weak var ticketButton: UIButton!
    
    // Properties
    var movie: Movie?
    var movieController = MovieController()
    var hideTicketButton: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // Button to show Trailer on YouTube
    @IBAction func playTrailerButton(_ sender: UIButton) {
        guard let movie = movie else { return }
        let movieID = String(movie.id)
        TrailerController.fetchVideo(for: movieID) { [weak self] (key) in
            if let key = key {
                DispatchQueue.main.async {
                         self?.playMovie(with: key)
                }
            }
        }
    }
    
    // Button to show Fandango website
    @IBAction func getTicketsButton(_ sender: UIButton) {
        guard let movie = movie else { return }
        let title = movie.title
        let movieTitle = title.replacingOccurrences(of: " ", with: "%20")
        showSafariVC(url: "https://www.fandango.com/search/?q=\(movieTitle)")
    }
    
    func updateViews() {
        guard let movie = movie else { return }
        navigationItem.title = movie.title
        playingMovieDetailRating.text = "\(movie.voteAverage)"
        playingMovieDetailOverview.text = movie.overview
        playingMovieID.text = "\(movie.id)"
        playingMovieID.isHidden = true
        
        if playingMovieDetailRating.text == "\(0.0)" {
            playingMovieDetailRating.text = "TBD"
            outOf10.isHidden = true
        } else {
            playingMovieDetailRating.text = "\(movie.voteAverage)"
        }
        if hideTicketButton == true {
            ticketButton.isHidden = true
        }
        
        // Fetch/Set image for movie
        movieController.fetchMovieImage(movie: movie) { [weak self] (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self?.playingMovieDetailImage.image = image
            }
        }
        playingMovieDetailImage.applyShadow()
        playTrailerButton.updateButtonViews()
        ticketButton.updateButtonViews()
    }
}

