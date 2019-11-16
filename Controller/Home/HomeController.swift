//
//  HomeController.swift
//  FH Schadenmelder
//
//  Created by Nemanja Filipovic on 10.11.19.
//  Copyright © 2019 Nemanja Filipovic, Michael Prammer, Elmi  Abdullahi. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class HomeController: UIViewController {


    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
    
  override var prefersStatusBarHidden: Bool {
      return true
  }
    
    @IBAction func LogoutButton(_ sender: Any) {
        try! Auth.auth().signOut()
        print("Logout successful")
        let vc = LoginController()
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
    }
}
