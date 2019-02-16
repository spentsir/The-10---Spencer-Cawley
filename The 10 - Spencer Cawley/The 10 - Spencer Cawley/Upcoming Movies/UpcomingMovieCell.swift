//
//  UpcomingMovieCell.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/15/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit

class UpcomingMovieCell: UITableViewCell {
    
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateImageView()
    }
    
    @IBOutlet weak var upcomingMovieImage: UIImageView!
    @IBOutlet weak var upcomingMovieTitle: UILabel!
    @IBOutlet weak var upcomingMovieRating: UILabel!
    @IBOutlet weak var upcomingMovieOverview: UILabel!
    
    
    func updateViews() {
        guard let movie = movie else { return }
        upcomingMovieTitle.text = movie.title
        upcomingMovieRating.text = "\(movie.voteAverage)"
        upcomingMovieOverview.text = movie.overview
        upcomingMovieRating.isHidden = true
    }
    
    func updateImageView() {
        upcomingMovieImage.layer.cornerRadius    = 20
        
        upcomingMovieImage.layer.shadowColor     = UIColor.black.cgColor
        upcomingMovieImage.layer.shadowOffset    = CGSize(width: 0.0, height: 6.0)
        upcomingMovieImage.layer.shadowRadius    = 8
        upcomingMovieImage.layer.shadowOpacity   = 0.5
        upcomingMovieImage.clipsToBounds         = true
        upcomingMovieImage.layer.masksToBounds   = false
    }
}