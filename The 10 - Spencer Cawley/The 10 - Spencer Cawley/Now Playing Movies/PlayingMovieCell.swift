//
//  MovieTableViewCell.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/13/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit

class PlayingMovieCell: UITableViewCell {

    // properties
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    // IBOutlets
    @IBOutlet weak var playingMovieImage: UIImageView!
    @IBOutlet weak var playingMovieTitle: UILabel!
    @IBOutlet weak var playingMovieOverview: UILabel!
    @IBOutlet weak var playingMovieRating: UILabel!
    @IBOutlet weak var playingMovieID: UILabel!
    
    
    // Updateviews Function
    func updateViews() {
        guard let movie = movie else { return }
        playingMovieTitle.text = movie.title
        playingMovieRating.text = "\(movie.voteAverage)"
        playingMovieID.text = "\(movie.id)"
        playingMovieOverview.text = movie.overview
        playingMovieRating.isHidden = true
        
        // apply shadow to image
        playingMovieImage.applyShadow()
    }
}
