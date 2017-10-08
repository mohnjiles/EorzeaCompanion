//
//  CharacterSearch.swift
//  Eorzea Companion
//
//  Created by JT Miles on 10/8/17.
//  Copyright © 2017 JT Miles. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CharacterSearch {
    let name: String
    let id: Int
    let server: String
    
    init(json: JSON) throws {
        name = json["characters"]["results"][0]["name"].stringValue.capitalized
        id = json["characters"]["results"][0]["id"].intValue
        server = json["characters"]["results"][0]["server"].stringValue.capitalized
        
    }
    
}
