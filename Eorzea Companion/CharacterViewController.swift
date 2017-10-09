//
//  CharacterViewController.swift
//  Eorzea Companion
//
//  Created by JT Miles on 10/8/17.
//  Copyright © 2017 JT Miles. All rights reserved.
//

import UIKit
import Siesta

class CharacterViewController: UIViewController, ResourceObserver {
    
    let lodestoneService = LodestoneService()
    var statusOverlay = ResourceStatusOverlay()
    
    @IBOutlet weak var avatarImageView: RemoteImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    var characterResource: Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
            
            characterResource?
                .addObserver(self)
                .addObserver(statusOverlay, owner: self)
                .loadIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusOverlay.embed(in: self)
        
        showCharacterInfo()
    }
    
    override func viewDidLayoutSubviews() {
        statusOverlay.positionToCoverParent()
    }
    
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        showCharacterInfo()
    }
    
    var currentCharacter: Character? {
        return characterResource?.typedContent()
    }
    
    func showCharacterInfo() {
        if let character = currentCharacter {
            avatarImageView?.imageURL = character.characterData?.avatarUrl
            characterNameLabel?.text = character.name
            self.title = character.name
        }
    }
    
    
}
