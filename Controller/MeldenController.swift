//
//  MeldenController.swift
//  FH Schadenmelder
//
//  Created by Filipovic Nemanja on 21.12.19.
//  Copyright © 2019 Nemanja Filipovic, Michael Prammer, Elmi  Abdullahi. All rights reserved.
//

import UIKit
import ProgressHUD
import FirebaseStorage
import FirebaseDatabase

class MeldenController: UIViewController {

    @IBOutlet weak var typeOfDamage: UITextField!
    @IBOutlet weak var placeOfDamage: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var takeImage: UIButton!
    @IBOutlet weak var deleteImage: UIButton!
    @IBOutlet weak var note: UITextView!
    @IBOutlet weak var send: UIButton!
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addTargetToTheTextField()
        send.isHidden = true
        let imageTemp = UIImage(named: "image.jpg")
        image.image = imageTemp
        selectedImage = imageTemp
    }
    
    // MARK: - Dismiss Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Do not show send if text fields empty
    @objc func textFieldDidChange(){
        let isText = typeOfDamage.text?.count ?? 0 > 0 && placeOfDamage.text?.count ?? 0 > 0
        
        if isText {
            send.isHidden = false
        } else {
            send.isHidden = true
        }
    }
    
    // MARK: - Add targets
    func addTargetToTheTextField() {
        typeOfDamage.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        placeOfDamage.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    func uploadNewDamageEntryToDatabase() {
        ProgressHUD.show("Laden...", interaction: false)
        
        guard let image = selectedImage else { return }
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
        let imageId = NSUUID().uuidString
        
        let storageRef = Storage.storage().reference().child("Eintrag_Fotos").child(imageId)
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if error != nil {
                print(error?.localizedDescription)
                ProgressHUD.showError("Fehler - Bild kann nicht hochgeladen werden")
                return
            }
            
            storageRef.downloadURL { (url, error) in
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }

                let imageDataUrlString = url?.absoluteString
                print("ovje treba da dodje")
                print(imageDataUrlString!)
                self.uploadDataToDatabase(imageUrl: imageDataUrlString!, imageId: imageId)
                print("odeeeeee")
                
            }
        }
        
    }

    func uploadDataToDatabase(imageUrl: String, imageId: String) {
        let databaseRef = Database.database().reference().child("Eintragae").child(imageId)
        
        var schadenOrtString: String = ""
        var schadenArtString: String = ""
        var schadenNotizString: String = ""
        
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: date)
        
        
        schadenNotizString = String(note.text!)
        schadenArtString = String(typeOfDamage.text!)
        schadenOrtString = String(placeOfDamage.text!)
        
        
        databaseRef.setValue(["Foto" : imageUrl, "Schadenart" : schadenArtString, "Schadenort" : schadenOrtString, "Notiz" : schadenNotizString, "Date": result, "Time": "\(hour):\(minutes)"]) { (error, ref) in
            if error != nil {
                ProgressHUD.showError("Daten konnten nicht hochgeladen werden")
                return
            }
            ProgressHUD.showSuccess("Eintrag erstellt")
            DispatchQueue.main.async {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
                    self.tabBarController?.selectedIndex = 0
                }
            }
        }
    }


    @IBAction func sendButtonPressed(_ sender: Any) {
        print("sending data")
        uploadNewDamageEntryToDatabase()
        print("done")
    }
    
    @IBAction func deletePhotoPressed(_ sender: Any) {
        let imageTemp = UIImage(named: "image.jpg")
        image.image = imageTemp
    }
    
}
