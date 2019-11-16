//
//  LoginController.swift
//  FH Schadenmelder
//
//  Created by Nemanja Filipovic on 10.11.19.
//  Copyright © 2019 Nemanja Filipovic, Michael Prammer, Elmi  Abdullahi. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    

    override func viewDidLoad() {
        usernameField.delegate = self
        passwordField.delegate = self
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
    
    @IBAction func loginButton(_ sender: Any) {
        Auth.auth().signIn(withEmail: usernameField.text!, password: passwordField.text!) { (user, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
        print("Login successful")
        let vc = HomeController()
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
        }

    }
}
