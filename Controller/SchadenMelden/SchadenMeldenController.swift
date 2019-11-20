//
//  SchadenMeldenController.swift
//  FH Schadenmelder
//
//  Created by Nemanja Filipovic on 16.11.19.
//  Copyright © 2019 Nemanja Filipovic, Michael Prammer, Elmi  Abdullahi. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage
import ProgressHUD

class SchadenMeldenController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var schadenArt: UITextField!
    @IBOutlet weak var schadenOrt: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var schadenFotoImage: UIImageView!
    
    // MARK: - var / let
    
    var selectedImage: UIImage?
    
    // MARK: - Dismiss Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
    
    func uploadNewDamageEntryToDatabase(image: String) {
        ProgressHUD.show("Laden...", interaction: false)
        let imageId = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("Einträge").child(imageId)
        
        
        
        //let databaseRef = Database.database().reference().child("Einträge")
        
    }

    @IBAction func sendButton(_ sender: Any) {
        print("senddd")
        uploadNewDamageEntryToDatabase(image: "lele")
    }
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func addTargetToTheTextField() {
        schadenArt.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        schadenOrt.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    
    // MARK: - Choose photo
    
    func addPhotoForSchaden() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto))
        schadenFotoImage.addGestureRecognizer(tapGesture)
        schadenFotoImage.isUserInteractionEnabled = true
    }
    
    @objc func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
        print("lalalalalal")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedPhoto = info[.cropRect] as? UIImage {
            schadenFotoImage.image = editedPhoto
            selectedImage = editedPhoto
        } else if let originalImage = info[.originalImage] as? UIImage {
            schadenFotoImage.image = originalImage
            selectedImage = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func textFieldDidChange(){
        let isText = schadenArt.text?.count ?? 0 > 0 && schadenOrt.text?.count ?? 0 > 0
        
        if isText {
            sendButton.isHidden = false
        } else {
            sendButton.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        addTargetToTheTextField()
        sendButton.isHidden = true
        schadenOrt.delegate = self
        schadenArt.delegate = self
        addPhotoForSchaden()
    }
    
    @IBAction func makePhotoButtonPressed(_ sender: Any) {
        print("testjj")
        let vc = CameraController()
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
    

}
