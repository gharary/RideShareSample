//
//  RideCell.swift
//  SIXT_RideShare
//
//  Created by Mohammad Gharari on 7/16/21.
//

import UIKit

class RideCell: UITableViewCell {

    @IBOutlet  weak var rideImage:UIImageView!
    @IBOutlet  weak var rideModel:UILabel!
    @IBOutlet  weak var name:UILabel!
    @IBOutlet  weak var make:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
