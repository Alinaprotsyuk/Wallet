//
//  ReportTableViewCell.swift
//  Wallet
//
//  Created by ITA student on 9/25/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import UIKit

class ReportTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryColor: UIButton!
    
    @IBOutlet weak var categoryTitle: UILabel!
    
    @IBOutlet weak var categoryValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
