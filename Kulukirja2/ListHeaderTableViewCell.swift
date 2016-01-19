//
//  ListHeaderTableViewCell.swift
//  Kulukirja2
//
//  Created by Koulutus on 09/01/16.
//  Copyright © 2016 Koulutus. All rights reserved.
//

import UIKit

class ListHeaderTableViewCell: UITableViewCell {

    // total expense is displayed in footer cell
    @IBOutlet weak var expenseTotalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
