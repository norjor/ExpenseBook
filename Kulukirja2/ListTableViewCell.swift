//
//  ListTableViewCell.swift
//  Kulukirja2
//
//  Created by Koulutus on 05/01/16.
//  Copyright © 2016 Koulutus. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var expenseNameAsButtonTitle: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
