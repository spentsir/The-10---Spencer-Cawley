//
//  MovieDetailViewController.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/13/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit
import AVKit
import WebKit

class PlayingMovieDetailController: UIViewController, WKNavigationDelegate {
    
    var movie: Movie?
    var movieController = MovieController()
    var movieURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        updateImageView()
    }
    
    
    @IBOutlet weak var playingMovieDetailImage: UIImageView!
    @IBOutlet weak var playingMovieDetailRating: UILabel!
    @IBOutlet weak var playingMovieDetailOverview: UILabel!
    @IBOutlet weak var playingMovieID: UILabel!
    
    @IBAction func playTrailerButton(_ sender: UIButton) {
        guard let movie = movie else { return }
        let movieID = String(movie.id)
        fetchVideo(for: movieID)
    }
    
    
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
    
    func updateImageView() {
        playingMovieDetailImage.layer.cornerRadius    = 20
        
        playingMovieDetailImage.layer.shadowColor     = UIColor.black.cgColor
        playingMovieDetailImage.layer.shadowOffset    = CGSize(width: 0.0, height: 6.0)
        playingMovieDetailImage.layer.shadowRadius    = 8
        playingMovieDetailImage.layer.shadowOpacity   = 0.5
        playingMovieDetailImage.clipsToBounds         = true
        playingMovieDetailImage.layer.masksToBounds   = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toTrailerVC", let destinationVC = segue.destination as? PlayingMovieTrailerController else { return }
        destinationVC.url = sender as? URL
    }
}

extension PlayingMovieDetailController {

    func playMovie(with key: String) {
        let url = URL(string: "https://www.youtube.com/embed/\(key)")!
        performSegue(withIdentifier: "toTrailerVC", sender: url)
        print(url)
    }

    func fetchVideo(for movieId: String) {

        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=725427eb27bb2372e7c69e11e5256f55&language=en-US")!

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }


            guard let data = data else {return}

            let movie = try? JSONDecoder().decode(Trailer.self, from: data)
            DispatchQueue.main.async {
                self.playMovie(with: movie!.results!.first!.key!)
                print(movie!.results!.first!.key!)
            }

            }.resume()
    }
}

