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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateImageView()
    }
    
    // IBOutlets
    @IBOutlet weak var playingMovieImage        : UIImageView!
    @IBOutlet weak var playingMovieTitle        : UILabel!
    @IBOutlet weak var playingMovieOverview     : UILabel!
    @IBOutlet weak var playingMovieRating       : UILabel!
    @IBOutlet weak var playingMovieID           : UILabel!
    
    
    // Updateviews Function
    func updateViews() {
        guard let movie = movie else { return }
        playingMovieTitle.text                  = movie.title
        playingMovieRating.text                 = "\(movie.voteAverage)"
        playingMovieID.text                     = "\(movie.id)"
        playingMovieOverview.text               = movie.overview
        playingMovieRating.isHidden             = true
    }
    
    func updateImageView() {
        playingMovieImage.layer.cornerRadius    = playingMovieImage.frame.height / 5
        
        playingMovieImage.layer.shadowColor     = UIColor.black.cgColor
        playingMovieImage.layer.shadowOffset    = CGSize(width: 0.0, height: 6.0)
        playingMovieImage.layer.shadowRadius    = 8
        playingMovieImage.layer.shadowOpacity   = 0.5
//        playingMovieImage.clipsToBounds         = true
//        playingMovieImage.layer.masksToBounds   = false
    }
}
