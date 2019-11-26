//
//  SchadenListeStoryBoardController.swift
//  FH Schadenmelder
//
//  Created by Nemanja Filipovic on 26.11.19.
//  Copyright © 2019 Nemanja Filipovic, Michael Prammer, Elmi  Abdullahi. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SchadenListeStoryBoardController: UIViewController, UITableViewDataSource {

    
    @IBOutlet weak var tableViewStoryBoard: UITableView!
    
    // MARK - Array mit Eintragaen
    
    var eintraegeStoryBoard = [EintragModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewStoryBoard.register(SchadenViewCell.self, forCellReuseIdentifier: "liste")
        tableViewStoryBoard.dataSource = self
        loadEintraege()

        // Do any additional setup after loading the view.
    }
    
    func loadEintraege() {
        let refDatabase = Database.database().reference().child("Eintragae")
        
        refDatabase.observe(.childAdded) { (snapshot) in
            guard let dic = snapshot.value as? [String: Any] else { return }
            let newEintrag = EintragModel(dictionary: dic)
            self.eintraegeStoryBoard.append(newEintrag)
            self.tableViewStoryBoard.reloadData()
        }
        print(eintraegeStoryBoard)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewStoryBoard.dequeueReusableCell(withIdentifier: "liste", for: indexPath) as! SchadenViewCell
        cell.textLabel?.text = "SISURINA"
        
        
        return cell
    }
    
    @IBAction func backButtonStoryBoardPressed(_ sender: Any){
        let vc = HomeController()
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
