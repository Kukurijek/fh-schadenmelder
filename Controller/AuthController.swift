//
//  AuthController.swift
//  FH Schadenmelder
//
//  Created by Filipovic Nemanja on 21.12.19.
//  Copyright © 2019 Nemanja Filipovic, Michael Prammer, Elmi  Abdullahi. All rights reserved.
//

import UIKit
import ProgressHUD
import FirebaseAuth

class AuthController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            ProgressHUD.show("Laden...", interaction: false)
            DispatchQueue.main.async {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
                    let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainviewcontroller") as? UITabBarController
                    self.view.window?.rootViewController = homeViewController
                    self.view.window?.makeKeyAndVisible()
                    ProgressHUD.showSuccess("Login erfolgreich")
                }
            }
        }
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        ProgressHUD.show("Laden...", interaction: false)
        
        Auth.auth().signIn(withEmail: username.text!, password: password.text!) { (user, error) in
            if let err = error {
                print(err.localizedDescription)
                ProgressHUD.showError("Falsche Daten!")
                return
            }
            print("Login successful")
            ProgressHUD.showSuccess("Login erfolgreich")
                
        
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainviewcontroller") as? UITabBarController
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
        }

    }
}
