//
//  HistoryTableViewCell.swift
//  AppAuth
//
//  Created by MAC923_47 on 18/1/2563 BE.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var cus_lic: UILabel!
    @IBOutlet weak var name_svp: UILabel!
    @IBOutlet weak var receive_date: UILabel!
    @IBOutlet weak var receive_time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
