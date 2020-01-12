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
import ProgressHUD


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
        //table.allowsSelection = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadEntriesChanged()
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
        let status = entries[indexPath.row].status
        let note = entries[indexPath.row].note
        let responsiblePerson = entries[indexPath.row].responsiblePerson
        let statusAndNoteAndRP = "\n \n \n \nStatus:  \(status ?? "")  \n \nZuständig: \(responsiblePerson ?? "")\n \n\(note ?? "")"
        cell.note = statusAndNoteAndRP

        
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
    
    func loadEntriesChanged() {
        let refDatabase = Database.database().reference().child("Eintragae")
        refDatabase.observe(.childRemoved) { (snapshot) in
            guard let dic = snapshot.value as? [String: Any] else { return }
            let newEntry = EntryModel(dictionary: dic)
            self.entries = self.entries.filter() { $0 !== newEntry }
            self.table.reloadData()
        }
        print(entries)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! EntriesListCell
        self.imageTapped(image: cell.icon.image!, note: cell.note)
    }
    
    func imageTapped(image:UIImage, note: String?){
        let newImageView = UIImageView(image: image)
        
        let wsa = UIScreen.main.widthOfSafeArea()
        let hsa = UIScreen.main.heightOfSafeArea()
        newImageView.frame = CGRect(x: 0, y: 0, width: wsa, height: hsa)
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFill
        newImageView.isUserInteractionEnabled = true
        
        let textView = UITextView()
        textView.frame = CGRect(x: 0, y: 0, width: wsa, height: hsa)
        textView.font = UIFont(name: textView.font?.fontName ?? "HelveticaNeue-Bold", size: 18)
        textView.textColor = UIColor.red
        textView.backgroundColor = UIColor.white
        textView.text = note
        
        let buttonView = UIView()
        buttonView.frame = CGRect(x: 0, y: 0, width: wsa, height: hsa)
        buttonView.backgroundColor = .black
        buttonView.isUserInteractionEnabled = true
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .green
        button.setTitle("Erledigt", for: .normal)
        button.tintColor = .red
        button.center = buttonView.center
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        buttonView.addSubview(button)
 
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ShowImageFullSizeController.dismissTextView(_:)))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(ShowImageFullSizeController.dismissFullscreenImage(_:)))
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(ShowImageFullSizeController.dismissView(_:)))
        
        
        newImageView.addGestureRecognizer(tap2)
        textView.addGestureRecognizer(tap)
        buttonView.addGestureRecognizer(tap3)
        
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.view.addSubview(newImageView)
        if Role.email == "test2@gmail.com" {
            self.view.addSubview(buttonView)
        }
        self.view.addSubview(textView)


    }

    @objc func buttonAction(sender: UIButton!) {
       print("Button tapped")
     }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    @objc func dismissTextView(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    
    @objc func dismissView(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
}
