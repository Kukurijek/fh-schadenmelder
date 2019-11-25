//
//  SchadenViewCell.swift
//  FH Schadenmelder
//
//  Created by Nemanja Filipovic on 24.11.19.
//  Copyright © 2019 Nemanja Filipovic, Michael Prammer, Elmi  Abdullahi. All rights reserved.
//

import UIKit

class SchadenViewCell: UITableViewCell {
    
    @IBOutlet weak var schadenImage: UIImageView!
    @IBOutlet weak var schadenNummer: UILabel!

    var eintrag: EintragModel? {
        didSet{
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
