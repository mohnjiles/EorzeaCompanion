//
//  LodestoneService.swift
//  Eorzea Companion
//
//  Created by JT Miles on 10/8/17.
//  Copyright © 2017 JT Miles. All rights reserved.
//

import Foundation
import Siesta
import SwiftyJSON

class LodestoneService: Service {
    
    private let SwiftyJSONTransformer = ResponseContentTransformer
        { JSON($0.content as AnyObject) }
    
    init() {
        super.init(baseURL: "https://api.xivdb.com")
        
        self.configure {
            $0.pipeline[.parsing].add(
                self.SwiftyJSONTransformer,
                contentTypes: ["*/json"])
            
            self.configureTransformer("/search") {
                try CharacterSearch(json: $0.content)
            }
        }
    }
    
    var search: Resource { return resource("/search") }
    
    func characterSearch(name: String) -> Resource {
        return search.withParam("one", "characters")
                        .withParam("string", name)
    }
    
}
