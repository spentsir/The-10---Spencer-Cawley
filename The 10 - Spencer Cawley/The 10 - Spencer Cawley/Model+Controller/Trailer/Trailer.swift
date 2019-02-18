//
//  Trailer.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/16/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import Foundation

// Trailer Keys for videos to make sure trailer is shown, not a featurette
enum TrailerType: String {
    case Trailer
    case Featurette
}

// First API Layer
struct Trailer: Codable {
    var id: Int?
    var results: [TrailerData]?
}

// Second API Layer
struct TrailerData: Codable {
    var id: String?
    var key: String?
    var name: String?
    var site: String?
    var size: Int?
    var type: String?
}
