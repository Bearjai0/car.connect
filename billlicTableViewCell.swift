//
//  billlicTableViewCell.swift
//  CARCONNECT
//
//  Created by Admin_DeviOS on 3/2/2563 BE.
//  Copyright © 2563 carconnect.ac.th. All rights reserved.
//

import UIKit

class billlicTableViewCell: UITableViewCell {

    @IBOutlet weak var showtime: UILabel!
    @IBOutlet weak var showdate: UILabel!
    @IBOutlet weak var showlic: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
