//
//  SettingsController.swift
//  FH Schadenmelder
//
//  Created by Filipovic Nemanja on 21.12.19.
//  Copyright © 2019 Nemanja Filipovic, Michael Prammer, Elmi  Abdullahi. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func logOutPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError.localizedDescription)
        }
        print("Logout successful")
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "secondviewcontroller") as! AuthController
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    @IBAction func goToSettings(_ sender: Any) {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
