//
//  Entry.swift
//  FH Schadenmelder
//
//  Created by Nemanja Filipovic on 22.12.19.
//  Copyright © 2019 Nemanja Filipovic, Michael Prammer, Elmi  Abdullahi. All rights reserved.
//

import Foundation

class EntryModel {
    var date: String?
    var time: String?
    var note: String?
    var damagePlace: String?
    var damageType: String?
    var photo: String?
    var status: String?
    var responsiblePerson: String?

    
    init(dictionary: [String: Any] ) {
        date = dictionary["Date"] as? String
        note = dictionary["Notiz"] as? String
        damageType = dictionary["Schadenart"] as? String
        damagePlace = dictionary["Schadenort"] as? String
        time = dictionary["Time"] as? String
        photo = dictionary["Foto"] as? String
        status = dictionary["Status"] as? String
        responsiblePerson = dictionary["responsible person"] as? String

    }
    
}
