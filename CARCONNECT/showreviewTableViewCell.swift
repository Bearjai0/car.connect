//
//  showreviewTableViewCell.swift
//  CARCONNECT
//
//  Created by Admin_DeviOS on 21/1/2563 BE.
//  Copyright © 2563 carconnect.ac.th. All rights reserved.
//

import UIKit

class showreviewTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var imgstar: UIImageView!
    @IBOutlet weak var name_cus: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
