//
//  showselectserviceTableViewCell.swift
//  CARCONNECT
//
//  Created by Admin_DeviOS on 28/12/2562 BE.
//  Copyright © 2562 carconnect.ac.th. All rights reserved.
//

import UIKit

class showselectserviceTableViewCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var showlic: UILabel!
    @IBOutlet weak var showdate: UILabel!
    @IBOutlet weak var showtime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
