//
//  Audio.swift
//  Ditango
//
//  Created by Leticia Maia on 4/30/16.
//  Copyright © 2016 Leticia Maia. All rights reserved.
//

import Foundation

class Audio {
    var id : Int64!
    var filename : String!
    
    init (id: Int64, filename : String) {
        self.id = id;
        self.filename = filename
    }
}