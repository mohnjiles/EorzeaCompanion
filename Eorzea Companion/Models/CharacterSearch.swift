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
    let id: String
    let server: String
    let icon: String
    
    init(json: JSON) throws {
        name = json["name"].stringValue.capitalized
        id = json["id"].stringValue
        server = json["server"].stringValue.capitalized
        icon = json["icon"].stringValue
        
    }
    
}
