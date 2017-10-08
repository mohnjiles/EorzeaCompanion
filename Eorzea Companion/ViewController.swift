//
//  ViewController.swift
//  Eorzea Companion
//
//  Created by JT Miles on 10/8/17.
//  Copyright © 2017 JT Miles. All rights reserved.
//

import UIKit
import Siesta
import SwiftyJSON

class ViewController: UIViewController, ResourceObserver {

    let lodestoneService = LodestoneService()
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var btnReload: UIButton!
    
    var statusOverlay = ResourceStatusOverlay()
    var characterSearchResource: Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
            
            characterSearchResource?
                .addObserver(self)
                .addObserver(statusOverlay, owner: self)
                .loadIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusOverlay.embed(in: self)
        
        characterSearchResource = lodestoneService.characterSearch(name: "El Jeezus")
    }
    
    override func viewDidLayoutSubviews() {
        statusOverlay.positionToCoverParent()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lodestoneService.characterSearch(name: "El Jeezus")
            .loadIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        
        print(resource.typedContent() ?? [])
        
        if let character: CharacterSearch? = characterSearchResource?.typedContent() {
            characterNameLabel.text = character?.name
        }
    
    }
    
    @IBAction func reload(_ sender: UIButton) {
        characterSearchResource?.load()
    }
}

