//
//  employee_ShowTableViewCell.swift
//  CARCONNECT
//
//  Created by Admin_DeviOS on 30/1/2563 BE.
//  Copyright © 2563 carconnect.ac.th. All rights reserved.
//

import UIKit

class employee_ShowTableViewCell: UITableViewCell {

    @IBOutlet weak var imageuse: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var imageE: UIImageView!
    @IBOutlet weak var edit1: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
