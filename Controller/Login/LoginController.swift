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
import SystemConfiguration.CaptiveNetwork
import ProgressHUD

class LoginController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    

    override func viewDidLoad() {
      //  usernameField.delegate = self
        //passwordField.delegate = self
        var a = UIDevice.current.identifierForVendor?.uuidString
        print(getWiFiSsid())
    }
    /*
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
     */
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    /*
 */
    /*
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    */
    @IBAction func loginButton(_ sender: Any) {
//        ProgressHUD.show("Laden...", interaction: false)
//        Auth.auth().signIn(withEmail: usernameField.text!, password: passwordField.text!) { (user, error) in
//            if let err = error {
//                print(err.localizedDescription)
//                ProgressHUD.showError("Falsche Daten!")
//                return
//            }
        print("Login successful")
        ProgressHUD.showSuccess("Login erfolgreich")
        
        let storyboard = UIStoryboard(name: "SchadenListe", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "liste") as UIViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)

//        let vc = HomeController()
//        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//        self.present(vc, animated: true, completion: nil)
       // }
    }
    
    
    func getWiFiSsid() -> String? {
    var ssid: String?
    if let interfaces = CNCopySupportedInterfaces() as NSArray? {
    for interface in interfaces {
    if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                    ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
    break
                }
            }
        }
    return ssid
    }
}
