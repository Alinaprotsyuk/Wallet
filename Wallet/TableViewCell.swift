//
//  TableViewCell.swift
//  Wallet
//
//  Created by ITA student on 9/18/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var valueOfTransaction: UILabel!
    
    @IBOutlet weak var infoOfTransaction: UILabel!
    
    @IBOutlet weak var describingOfTransaction: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
