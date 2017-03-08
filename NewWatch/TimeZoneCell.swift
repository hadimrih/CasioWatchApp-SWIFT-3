//
//  TimeZoneCell.swift
//  CasioWatchApp
//
//  Created by Hadi Mrih on 04/03/2017.
//  Copyright © 2017 Hadi Mrih. All rights reserved.
//

import UIKit

class TimeZoneCell: UITableViewCell {

    
    @IBOutlet weak var countryNameLbl: UILabel!
    
    @IBOutlet weak var zoneNameLbl: UILabel!

    @IBOutlet weak var countryCodeLbl: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
