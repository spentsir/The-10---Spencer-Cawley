//
//  UpcomingMovieCell.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/15/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit

class UpcomingMovieCell: UITableViewCell {
    
    // IBOutlets
    @IBOutlet weak var upcomingMovieImage: UIImageView!
    @IBOutlet weak var upcomingMovieTitle: UILabel!
    @IBOutlet weak var upcomingMovieRating: UILabel!
    @IBOutlet weak var upcomingMovieOverview: UILabel!
    
    // Properties
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    // UpdateViews Function
    func updateViews() {
        guard let movie = movie else { return }
        upcomingMovieTitle.text = movie.title
        upcomingMovieRating.text = "\(movie.voteAverage)"
        upcomingMovieOverview.text = movie.overview
        upcomingMovieRating.isHidden = true
        
        // apply shadow to image
        upcomingMovieImage.applyShadow()
    }
}
