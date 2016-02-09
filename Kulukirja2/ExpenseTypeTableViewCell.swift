//
//  ExpenseTypeTableViewCell
//  Kulukirja2
//
//  Created by Koulutus on 24/12/15.
//  Copyright © 2015 Koulutus. All rights reserved.
//

import UIKit

class ExpenseTypeTableViewCell: UITableViewCell {

    // type name button in table cell
    @IBOutlet weak var typeNameButton: UIButton!
    
    @IBAction func typeCellButton(sender: UIButton) {
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
