//
//  UpcomingMovieDetailController.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/15/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit
import AVKit
import WebKit

class UpcomingMovieDetailController: UIViewController, WKNavigationDelegate {
    
    var movie           : Movie?
    var movieController = MovieController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }
    
    @IBOutlet weak var upcomingMovieDetailImage     : UIImageView!
    @IBOutlet weak var upcomingMovieDetailRating    : UILabel!
    @IBOutlet weak var upcomingMovieDetailOverview: UILabel!
    
    @IBOutlet weak var upcomingMovieID              : UILabel!
    @IBOutlet weak var watchTrailerButton           : UIButton!
    
    @IBAction func watchTrailerButton(_ sender: UIButton) {
        guard let movie = movie else { return }
        let movieID     = String(movie.id)
        fetchVideo(for: movieID)
    }
    
    func updateViews() {
        guard let movie = movie else { return }
        navigationItem.title                = movie.title
        upcomingMovieDetailRating.text      = "\(movie.voteAverage)"
        upcomingMovieDetailOverview.text    = movie.overview
        upcomingMovieID.text                = "\(movie.id)"
        print(movie.id)
        
        
        movieController.fetchMovieImage(movie: movie) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.upcomingMovieDetailImage.image = image
            }
        }
        updateImageView()
        updateTrailerButton()
    }
    
    func updateImageView() {
        upcomingMovieDetailImage.layer.cornerRadius    = 20
        
        upcomingMovieDetailImage.layer.shadowColor     = UIColor.black.cgColor
        upcomingMovieDetailImage.layer.shadowOffset    = CGSize(width: 0.0, height: 9.0)
        upcomingMovieDetailImage.layer.shadowRadius    = 5
        upcomingMovieDetailImage.layer.shadowOpacity   = 0.5
        upcomingMovieDetailImage.clipsToBounds         = true
        upcomingMovieDetailImage.layer.masksToBounds   = false
    }
    
    func updateTrailerButton() {
        watchTrailerButton.backgroundColor              = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        watchTrailerButton.layer.cornerRadius           = watchTrailerButton.frame.height / 2
        watchTrailerButton.setTitleColor(Colors.veryDarkGrey, for: .normal)
        
        watchTrailerButton.layer.shadowColor            = UIColor.black.cgColor
        watchTrailerButton.layer.shadowOffset           = CGSize(width: 0.0, height: 6.0)
        watchTrailerButton.layer.shadowOpacity          = 0.5
        watchTrailerButton.layer.shadowRadius           = 8
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toUpcomingTrailerVC", let destinationVC = segue.destination as? UpcomingMovieTrailerController else { return }
        destinationVC.url       = sender as? URL
    }
}

extension UpcomingMovieDetailController {
    
    func playMovie(with key: String) {
        let url = URL(string: "https://www.youtube.com/embed/\(key)")!
        performSegue(withIdentifier: "toUpcomingTrailerVC", sender: url)
        print(url)
    }
    
    func fetchVideo(for movieId: String) {
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=725427eb27bb2372e7c69e11e5256f55&language=en-US")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data  = data else {return}
            let movie       = try? JSONDecoder().decode(Trailer.self, from: data)
            DispatchQueue.main.async {
                self.playMovie(with: movie!.results!.first!.key!)
                print(movie!.results!.first!.key!)
            }
            }.resume()
    }
}
