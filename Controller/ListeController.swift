//
//  ListeController.swift
//  FH Schadenmelder
//
//  Created by Filipovic Nemanja on 21.12.19.
//  Copyright © 2019 Nemanja Filipovic, Michael Prammer, Elmi  Abdullahi. All rights reserved.
//

import UIKit

class ListeController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var table: UITableView!
    
    var entries: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self

    }
    

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: "EntriesListCellIdentifier", for: indexPath) as? EntriesListCell else { fatalError() }
        

        cell.textLabel?.text = "TEST"
        
     return cell
     }
     


}
