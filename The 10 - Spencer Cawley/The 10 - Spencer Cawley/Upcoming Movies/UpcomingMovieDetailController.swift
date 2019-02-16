//
//  UpcomingMovieDetailController.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/15/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit

class UpcomingMovieDetailController: UIViewController {
    
    var movie: Movie?
    var movieController = MovieController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        updateImageView()
    }
    
    @IBOutlet weak var upcomingMovieDetailImage: UIImageView!
    @IBOutlet weak var upcomingMovieDetailRating: UILabel!
    @IBOutlet weak var upcomingMovieDetailOverview: UILabel!
    
    
    func updateViews() {
        guard let movie = movie else { return }
        navigationItem.title = movie.title
        upcomingMovieDetailRating.text = "\(movie.voteAverage)"
        upcomingMovieDetailOverview.text = movie.overview
        
        
        movieController.fetchMovieImage(movie: movie) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.upcomingMovieDetailImage.image = image
            }
        }
    }
    
    func updateImageView() {
        upcomingMovieDetailImage.layer.cornerRadius    = 20
        
        upcomingMovieDetailImage.layer.shadowColor     = UIColor.black.cgColor
        upcomingMovieDetailImage.layer.shadowOffset    = CGSize(width: 0.0, height: 6.0)
        upcomingMovieDetailImage.layer.shadowRadius    = 8
        upcomingMovieDetailImage.layer.shadowOpacity   = 0.5
        upcomingMovieDetailImage.clipsToBounds         = true
        upcomingMovieDetailImage.layer.masksToBounds   = false
    }
}
