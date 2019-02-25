//
//  TrailerController.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/21/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import UIKit

class TrailerController {
    
    // Fetching trailer function
    static func fetchVideo(for movieId: String, completion: @escaping(String?) -> Void) {
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=725427eb27bb2372e7c69e11e5256f55&language=en-US")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                error.customAlert(with: "We're having trouble finding this trailer. Please try again later.")
                return
            }
            
            guard let data = data else {return}
            let trailer = try? JSONDecoder().decode(Trailer.self, from: data)
            let returnString = playTrailer(trailer)
            completion(returnString)
            }.resume()
    }
    
    // Function to make sure trailers are pulled and not feature videos.
    // As well as pulling the highest video quality
    static func playTrailer(_ trailer: Trailer?) -> String {
        guard let trailer = trailer, let results = trailer.results else { return ""}
        let trailerResults = results
            .filter({$0.type == TrailerType.Trailer.rawValue})
            .sorted(by: { $0.size! > $1.size! })
        guard let result = trailerResults.first?.key else { return ""}
        return result
    }
}
