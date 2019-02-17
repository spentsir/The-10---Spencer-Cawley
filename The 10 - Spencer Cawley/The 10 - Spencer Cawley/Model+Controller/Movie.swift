//
//  Movie.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/13/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import Foundation

struct JSONDictionary: Decodable {
    let results         : [Movie]
}

struct Movie: Decodable {
    let voteAverage     : Double
    let title           : String
    let posterPath      : String?
    let overview        : String
    let id              : Int
    
    enum CodingKeys: String, CodingKey {
        case voteAverage = "vote_average"
        case title
        case posterPath  = "poster_path"
        case overview
        case id
    }
}
