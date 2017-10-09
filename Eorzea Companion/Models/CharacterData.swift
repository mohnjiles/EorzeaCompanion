//
//  CharacterData.swift
//  Eorzea Companion
//
//  Created by JT Miles on 10/8/17.
//  Copyright © 2017 JT Miles. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CharacterData {
    
    let title: String
    let avatarUrl: String
    let portraitUrl: String
    let biography: String
    let race: String
    let clan: String
    let gender: String
    let nameday: String
    
    
    init(json: JSON) throws {
        title = json["title"].stringValue
        avatarUrl = json["avatar"].stringValue
        portraitUrl = json["portrait"].stringValue
        biography = json["biography"].stringValue
        race = json["race"].stringValue
        clan = json["clan"].stringValue
        gender = json["gender"].stringValue
        nameday = json["nameday"].stringValue
    }
}
