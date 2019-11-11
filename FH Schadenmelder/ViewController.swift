//
//  ViewController.swift
//  FH Schadenmelder
//
//  Created by Nemanja Filipovic on 10.11.19.
//  Copyright © 2019 Nemanja Filipovic, Michael Prammer, Elmi  Abdullahi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func present(_ viewControllerToPresent: UIViewController,
                          animated flag: Bool,
                          completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sleep(2)
        present(LoginController(), animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = LoginController()
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: true, completion: nil)
        // Do any additional setup after loading the view.

    }


}

