//
//  SchadenListeController.swift
//  FH Schadenmelder
//
//  Created by Nemanja Filipovic on 10.11.19.
//  Copyright © 2019 Nemanja Filipovic, Michael Prammer, Elmi  Abdullahi. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class SchadenListeController : UIViewController, UITableViewDataSource {
        
    override func viewDidLoad() {
        loadEintraege()
    }
    
    func loadEintraege() {
        let refDatabase = Database.database().reference().child("Eintragae")
        
        refDatabase.observe(.childAdded) { (snapshot) in
            print(snapshot)
        }
        print(refDatabase)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "TESTTTTTTTtt"
        
        return cell
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
