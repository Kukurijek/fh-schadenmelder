//
//  extensions.swift
//  FH Schadenmelder
//
//  Created by Nemanja Filipovic on 13.11.19.
//  Copyright © 2019 Nemanja Filipovic, Michael Prammer, Elmi  Abdullahi. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}

extension UIScreen {

public func widthOfSafeArea() -> CGFloat {

    guard let rootView = UIApplication.shared.keyWindow else { return 0 }

    if #available(iOS 11.0, *) {

        let leftInset = rootView.safeAreaInsets.left

        let rightInset = rootView.safeAreaInsets.right

        return rootView.bounds.width - leftInset - rightInset

    } else {

        return rootView.bounds.width

    }

}

func heightOfSafeArea() -> CGFloat {

    guard let rootView = UIApplication.shared.keyWindow else { return 0 }

    if #available(iOS 11.0, *) {

        let topInset = rootView.safeAreaInsets.top

        let bottomInset = rootView.safeAreaInsets.bottom

        return rootView.bounds.height - topInset - bottomInset

    } else {

        return rootView.bounds.height

    }

}
}
