//
//  ShowServiceTableViewCell.swift
//  CARCONNECT
//
//  Created by MAC923_47 on 18/1/2563 BE.
//  Copyright © 2563 carconnect.ac.th. All rights reserved.
//

import UIKit

class ShowServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var showtime: UILabel!
    @IBOutlet weak var namedata: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
