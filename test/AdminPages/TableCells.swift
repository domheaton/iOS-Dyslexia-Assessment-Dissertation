//
//  TableCells.swift
//  test
//
//  Created by Dominic Heaton on 25/10/2017.
//  Copyright © 2017 Dominic Heaton. All rights reserved.
//

import UIKit

class TableCells: UITableViewCell {
    
    //The label used in the cell's of the table
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelTest: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
