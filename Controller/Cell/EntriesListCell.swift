//
//  EntriesListCell.swift
//  FH Schadenmelder
//
//  Created by Filipovic Nemanja on 21.12.19.
//  Copyright © 2019 Nemanja Filipovic, Michael Prammer, Elmi  Abdullahi. All rights reserved.
//

import UIKit

class EntriesListCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var icon: UIImageView!
    var note: String?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
