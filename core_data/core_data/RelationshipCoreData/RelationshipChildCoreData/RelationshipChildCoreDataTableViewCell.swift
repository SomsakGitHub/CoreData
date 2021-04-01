//
//  RelationshipChildCoreDataTableViewCell.swift
//  core_data
//
//  Created by somsak on 30/3/2564 BE.
//

import UIKit

class RelationshipChildCoreDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configView(data: CityRel){
        self.nameLabel.text = data.name
    }
}
