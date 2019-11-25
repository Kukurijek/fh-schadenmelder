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

class SchadenListeController : UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK - Array mit Eintraege
    var eintraege = [EintragModel]()
    
    override func viewDidLoad() {
        self.tableView.register(SchadenViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self

        loadEintraege()

    }
    
    func loadEintraege() {
        let refDatabase = Database.database().reference().child("Eintragae")
        
        refDatabase.observe(.childAdded) { (snapshot) in
            guard let dic = snapshot.value as? [String: Any] else { return }
            let newEintrag = EintragModel(dictionary: dic)
            self.eintraege.append(newEintrag)
            self.tableView.reloadData()
        }
        print(refDatabase)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eintraege.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SchadenViewCell
        
        //cell.textLabel?.text = "TESTTTTTTTtt"
        //cell.schadenImage
        cell.textLabel?.text = eintraege[indexPath.row].schadenArt
        cell.detailTextLabel?.text = "asdqsadaasdads"
        cell.schadenNummer?.text = eintraege[indexPath.row].schadenArt
        
        var aa = eintraege[indexPath.row].schadenArt
        print(eintraege[indexPath.row].schadenArt)
        
        return cell
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        let vc = HomeController()
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
}
