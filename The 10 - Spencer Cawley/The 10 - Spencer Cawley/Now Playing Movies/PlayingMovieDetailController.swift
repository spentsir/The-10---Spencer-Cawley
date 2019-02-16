//
//  MovieDetailViewController.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/13/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import WebKit

class PlayingMovieDetailController: UIViewController {
    
    var movie: Movie?
    var movieController = MovieController()
    //    var videoPlayer = VideoPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }
    
    @IBOutlet weak var playingMovieDetailImage: UIImageView!
    @IBOutlet weak var playingMovieDetailRating: UILabel!
    @IBOutlet weak var playingMovieDetailOverview: UILabel!
    @IBOutlet weak var playingMovieID: UILabel!
    
    
    
    
    func updateViews() {
        guard let movie = movie else { return }
        navigationItem.title = movie.title
        playingMovieDetailRating.text = "\(movie.voteAverage)"
        playingMovieDetailOverview.text = movie.overview
        playingMovieID.text = "\(movie.id)"
        playingMovieID.isHidden = true
        print(movie.id)
        
        movieController.fetchMovieImage(movie: movie) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.playingMovieDetailImage.image = image
            }
        }
    }
}

