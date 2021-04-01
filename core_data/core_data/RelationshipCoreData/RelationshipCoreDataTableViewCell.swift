//
//  RelationshipCoreDataTableViewCell.swift
//  core_data
//
//  Created by somsak on 1/4/2564 BE.
//

import UIKit

class RelationshipCoreDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configView(data: CountryRel){
        self.nameLabel.text = data.name
    }
}

