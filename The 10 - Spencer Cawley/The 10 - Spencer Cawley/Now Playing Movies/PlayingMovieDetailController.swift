//
//  MovieDetailViewController.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/13/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit
import SafariServices

class PlayingMovieDetailController: UIViewController {
    
    var movie: Movie?
    var movieController = MovieController()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBOutlet weak var playingMovieDetailImage: UIImageView!
    @IBOutlet weak var playingMovieDetailRating: UILabel!
    @IBOutlet weak var playingMovieDetailOverview: UILabel!
    @IBOutlet weak var playingMovieID: UILabel!
    @IBOutlet weak var playTrailerButton: UIButton!
    @IBOutlet weak var ticketButton: UIButton!
    
    
    @IBAction func playTrailerButton(_ sender: UIButton) {
        guard let movie = movie else { return }
        let movieID = String(movie.id)
        fetchVideo(for: movieID)
    }
    
    @IBAction func getTicketsButton(_ sender: UIButton) {
        guard let movie = movie else { return }
        let title = movie.title
        let movieTitle = title.replacingOccurrences(of: " ", with: "%20")
        showSafariVC(url: "https://www.fandango.com/search/?q=\(movieTitle)")
    }
    
    func showSafariVC(url: String) {
        guard let url = URL(string: url) else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    
    
    func updateViews() {
        guard let movie = movie else { return }
        navigationItem.title = movie.title
        playingMovieDetailRating.text = "\(movie.voteAverage)"
        playingMovieDetailOverview.text = movie.overview
        playingMovieID.text = "\(movie.id)"
        playingMovieID.isHidden = true
        print(movie.id)
        print(movie.title)
        
        movieController.fetchMovieImage(movie: movie) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.playingMovieDetailImage.image = image
            }
        }
        updateImageView()
        updateTrailerButton()
        updateTicketButton()
    }
    
    func updateImageView() {
        playingMovieDetailImage.layer.cornerRadius    = 20
        
        playingMovieDetailImage.layer.shadowColor     = UIColor.black.cgColor
        playingMovieDetailImage.layer.shadowOffset    = CGSize(width: 0.0, height: 9.0)
        playingMovieDetailImage.layer.shadowRadius    = 5
        playingMovieDetailImage.layer.shadowOpacity   = 0.5
        playingMovieDetailImage.clipsToBounds         = true
        playingMovieDetailImage.layer.masksToBounds   = false
    }
    
    func updateTrailerButton() {
        playTrailerButton.setTitleColor(Colors.veryDarkGrey, for: .normal)
        playTrailerButton.setTitleColor(Colors.red, for: .highlighted)
        playTrailerButton.backgroundColor             = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        playTrailerButton.layer.cornerRadius          = playTrailerButton.frame.height / 2
        
        playTrailerButton.layer.shadowColor           = UIColor.black.cgColor
        playTrailerButton.layer.shadowOffset          = CGSize(width: 0.0, height: 6.0)
        playTrailerButton.layer.shadowOpacity         = 0.5
        playTrailerButton.layer.shadowRadius          = 8
    }
    
    func updateTicketButton() {
        ticketButton.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        ticketButton.layer.cornerRadius = ticketButton.frame.height / 2
        
        ticketButton.layer.shadowOpacity = 0.5
        ticketButton.layer.shadowRadius = 8
        ticketButton.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        ticketButton.layer.shadowColor = UIColor.black.cgColor
    }
}

extension PlayingMovieDetailController {

    func playMovie(with key: String) {
        showSafariVC(url: "https://www.youtube.com/embed/\(key)")
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

