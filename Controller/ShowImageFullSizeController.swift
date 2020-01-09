//
//  ShowImageFullSizeController.swift
//  FH Schadenmelder
//
//  Created by Nemanja Filipovic on 09.01.20.
//  Copyright © 2020 Nemanja Filipovic, Michael Prammer, Elmi  Abdullahi. All rights reserved.
//

import UIKit

class ShowImageFullSizeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }

    @objc func dismissTextView(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
}
