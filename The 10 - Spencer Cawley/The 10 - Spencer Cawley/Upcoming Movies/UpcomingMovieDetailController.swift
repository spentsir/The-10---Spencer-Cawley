//
//  UpcomingMovieDetailController.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/15/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit
import SafariServices

class UpcomingMovieDetailController: UIViewController {
    
    // Properties
    var movie: Movie?
    var movieController = MovieController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }
    
    // IBOutlets
    @IBOutlet weak var upcomingMovieDetailImage: UIImageView!
    @IBOutlet weak var upcomingMovieDetailRating: UILabel!
    @IBOutlet weak var upcomingMovieDetailOverview: UILabel!
    @IBOutlet weak var outOf10: UILabel!
    @IBOutlet weak var upcomingMovieID: UILabel!
    @IBOutlet weak var watchTrailerButton: UIButton!
    
    // Button to show Trailers
    @IBAction func watchTrailerButton(_ sender: UIButton) {
        guard let movie = movie else { return }
        let movieID = String(movie.id)
        fetchVideo(for: movieID)
    }
    
    // Button to show Fandango
    func showSafariVC(url: String) {
        guard let url = URL(string: url) else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    func updateViews() {
        guard let movie = movie else { return }
        navigationItem.title = movie.title
        upcomingMovieDetailOverview.text = movie.overview
        upcomingMovieID.text = "\(movie.id)"
        
        // If movie rating is 0 from API, set it to TBD
        if upcomingMovieDetailRating.text == "\(0.0)" {
            upcomingMovieDetailRating.text = "TBD"
            outOf10.isHidden = true
        } else {
            upcomingMovieDetailRating.text = "\(movie.voteAverage)"
        }
        
        // Fetch/Set image for movie
        movieController.fetchMovieImage(movie: movie) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.upcomingMovieDetailImage.image = image
            }
        }
        setImageViewShadow()
        updateTrailerButton()
    }
    
    // Set ImageView DropShadow
    func setImageViewShadow() {
        upcomingMovieDetailImage.layer.shadowColor = UIColor.black.cgColor
        upcomingMovieDetailImage.layer.shadowOffset = CGSize(width: 0.0, height: 9.0)
        upcomingMovieDetailImage.layer.shadowRadius = 5
        upcomingMovieDetailImage.layer.shadowOpacity = 0.5
    }
    
    // Make Trailer Button Round/DropShadow
    func updateTrailerButton() {
        watchTrailerButton.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        watchTrailerButton.layer.cornerRadius = watchTrailerButton.frame.height / 2
        watchTrailerButton.setTitleColor(Colors.veryDarkGrey, for: .normal)
        
        watchTrailerButton.layer.shadowColor = UIColor.black.cgColor
        watchTrailerButton.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        watchTrailerButton.layer.shadowOpacity = 0.5
        watchTrailerButton.layer.shadowRadius = 8
    }
}

// Extension for playing Trailers
extension UpcomingMovieDetailController {
    
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
            let trailer = try? JSONDecoder().decode(Trailer.self, from: data)
            DispatchQueue.main.async {
                self.playTrailer(trailer)
            }
            }.resume()
    }
    
    // Function to make sure trailers are pulled and not feature videos.
    // As well as pulling the highest video quality
    func playTrailer(_ trailer: Trailer?) {
        guard let trailer = trailer, let results = trailer.results else { return }
        let trailerResults = results
            .filter({$0.type == TrailerType.Trailer.rawValue})
            .sorted(by: { $0.size! > $1.size! })
        
        playMovie(with: trailerResults.first!.key!)
    }
}
