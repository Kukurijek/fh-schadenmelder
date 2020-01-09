//
//  ListeController.swift
//  FH Schadenmelder
//
//  Created by Filipovic Nemanja on 21.12.19.
//  Copyright © 2019 Nemanja Filipovic, Michael Prammer, Elmi  Abdullahi. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage


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
        let urlString: String = self.entries[indexPath.row].photo ?? "https://firebasestorage.googleapis.com/v0/b/fh-schadenmelder.appspot.com/o/Eintrag_Fotos%2F31CD244F-BD06-4AF2-94D8-6486BD5C441E?alt=media&token=f32325cd-6b7f-4542-a797-1958036592b5"
        guard let url = URL(string: urlString) else { fatalError() }
        cell.icon.sd_setImage(with: url ) { (_, _, _, _) in
        }
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
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let cell = table.cellForRow(at: indexPath) as! EntriesListCell
//        self.addIm
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! EntriesListCell
        self.imageTapped(image: cell.icon.image!)
    }
    
    func imageTapped(image:UIImage){
        let newImageView = UIImageView(image: image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ShowImageFullSizeController.dismissFullscreenImage(_:)))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }

    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
}
