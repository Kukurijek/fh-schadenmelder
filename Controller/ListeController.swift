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
    
    var entries = [EntryModel]()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        loadEntries()
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: "EntriesListCellIdentifier", for: indexPath) as? EntriesListCell else { fatalError() }
        
        cell.date.text = entries[indexPath.row].date
        cell.time.text = entries[indexPath.row].time
        cell.category.text = entries[indexPath.row].damagePlace
        cell.title.text = entries[indexPath.row].damageType
        //cell.icon. = entries[indexPath.row].photo
        cell.time.text = entries[indexPath.row].time

        
        return cell
     }
     
    func loadEntries() {
        let refDatabase = Database.database().reference().child("Eintragae")
        
        refDatabase.observe(.childAdded) { (snapshot) in
            guard let dic = snapshot.value as? [String: Any] else { return }
            let newEntry = EntryModel(dictionary: dic)
            self.entries.append(newEntry)
            self.table.reloadData()
        }
        print(entries)
    }


}
