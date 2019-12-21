//
//  ListeController.swift
//  FH Schadenmelder
//
//  Created by Filipovic Nemanja on 21.12.19.
//  Copyright © 2019 Nemanja Filipovic, Michael Prammer, Elmi  Abdullahi. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ListeController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var table: UITableView!
    
    var entries: [EintragModel] = []
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        loadEintries()
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: "EntriesListCellIdentifier", for: indexPath) as? EntriesListCell else { fatalError() }
        
        cell.date.text = "testdate"
        cell.title.text = "eeeee"
        cell.time.text = "asewe"
        //cell.textLabel?.text = "TEST"
        
     return cell
     }
     
    func loadEintries() {
        let refDatabase = Database.database().reference().child("Eintragae")
        
        refDatabase.observe(.childAdded) { (snapshot) in
            guard let dic = snapshot.value as? [String: Any] else { return }
            let newEintrag = EintragModel(dictionary: dic)
            self.entries.append(newEintrag)
            self.table.reloadData()
        }
        print(refDatabase)
    }


}
