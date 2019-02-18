//
//  Movie.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/13/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import Foundation

// First API Layer
struct JSONDictionary: Codable {
    let results: [Movie]
}

// Second API Layer
struct Movie: Codable {
    let voteAverage: Double
    let title: String
    let posterPath: String?
    let overview: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case voteAverage = "vote_average"
        case title
        case posterPath = "poster_path"
        case overview
        case id
    }
}
