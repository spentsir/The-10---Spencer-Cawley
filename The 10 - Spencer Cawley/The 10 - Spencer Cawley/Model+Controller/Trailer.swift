//
//  Trailer.swift
//  The 10 - Spencer Cawley
//
//  Created by Spencer Cawley on 2/16/19.
//  Copyright © 2019 Spencer Cawley. All rights reserved.
//

import Foundation

class Trailer: Codable {
    
    var id: Int?
    var results: [TrailerData]?
    
    init(id: Int?, results: [TrailerData]?) {
        self.id = id
        self.results = results
    }
}

class TrailerData: Codable {
    
    var id: String?
    var key: String?
    var name: String?
    var site: String?
    var size: Int?
    var type: String?
    
    init(id: String?, key: String?, name: String?, site: String?, size: Int?, type: String?) {
        self.id = id
        self.key = key
        self.name = name
        self.site = site
        self.size = size
        self.type = type
    }
}
