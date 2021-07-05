//
//  EventTableViewCell.swift
//  AQ_Fetch
//
//  Created by Mando Quintana on 6/23/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var localDateLabel: UILabel!
    @IBOutlet var stateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
