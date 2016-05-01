//
//  Document.swift
//  Ditango
//
//  Created by Leticia Maia on 4/30/16.
//  Copyright © 2016 Leticia Maia. All rights reserved.
//

import Foundation

class Document {
    var id : Int64!
    var filename : String!
    var audio: Audio?
    
    init (id: Int64, filename : String, audio: Audio?) {
        self.id = id
        self.filename = filename
        self.audio = audio
    }
    
}
