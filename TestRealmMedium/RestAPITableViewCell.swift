//
//  RestAPITableViewCell.swift
//  TestRealmMedium
//
//  Created by Elle Ti on 2018-06-12.
//  Copyright © 2018 Elle Ti. All rights reserved.
//

import UIKit

class RestAPITableViewCell: UITableViewCell {
    
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var completedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
