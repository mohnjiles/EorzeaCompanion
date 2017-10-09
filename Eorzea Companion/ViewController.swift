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

class ViewController: UIViewController, ResourceObserver, UITableViewDelegate, UITableViewDataSource {

    let lodestoneService = LodestoneService()
    @IBOutlet weak var btnReload: UIButton!
    @IBOutlet weak var charactersTableView: UITableView!
    @IBOutlet weak var characterNameTextField: UITextField!
    
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
    
    var characterList: [CharacterSearch] = [] {
        didSet {
            charactersTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusOverlay.embed(in: self)
        
        self.title = "Eorzea Companion"
        
        characterSearchResource = lodestoneService.characterSearch(name: "El Jeezus")
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        statusOverlay.positionToCoverParent()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lodestoneService.characterSearch(name: "El Jeezus")
            .loadIfNeeded()
        characterSearchResource?.loadIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        characterList = characterSearchResource?.typedContent() ?? []
    }
    
    @IBAction func reload(_ sender: UIButton) {
        characterSearchResource = lodestoneService.characterSearch(name: characterNameTextField.text ?? "El Jeezus")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = charactersTableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)
            as? CharacterSearchTableViewCell else {
                fatalError("The dequeued cell is not an instance of CharacterSearchTableViewCell")
            }
        
        let character = characterList[indexPath.row]
        
        cell.characterNameLabel?.text = character.name
        cell.characterImageView.imageURL = character.icon
        cell.characterServerLabel.text = character.server
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCharacterDetailSegue" {
            if let characterVC = segue.destination as? CharacterViewController,
                let indexPath = self.charactersTableView.indexPathForSelectedRow {
                characterVC.characterResource = lodestoneService.characterSearchById(id: characterList[indexPath.row].id)
                self.charactersTableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    

    
    
}

