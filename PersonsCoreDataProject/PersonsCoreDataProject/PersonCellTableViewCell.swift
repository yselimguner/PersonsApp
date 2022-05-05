//
//  PersonCellTableViewCell.swift
//  PersonsCoreDataProject
//
//  Created by Yavuz Güner on 1.05.2022.
//

import UIKit

class PersonCellTableViewCell: UITableViewCell {
    @IBOutlet weak var personInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
