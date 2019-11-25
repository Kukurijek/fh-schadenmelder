//
//  EintragModel.swift
//  FH Schadenmelder
//
//  Created by Nemanja Filipovic on 25.11.19.
//  Copyright © 2019 Nemanja Filipovic, Michael Prammer, Elmi  Abdullahi. All rights reserved.
//

import Foundation


class EintragModel {
    
    var imageUrl: String?
    var schadenArt: String?
    
    init(dictionary: [String: Any]) {
        schadenArt = dictionary["Schadenart"] as? String
        imageUrl = dictionary["Foto"] as? String
    }
}
