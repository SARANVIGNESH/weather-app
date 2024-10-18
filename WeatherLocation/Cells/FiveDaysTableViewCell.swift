//
//  FiveDaysTableViewCell.swift
//  WeatherLocation
//
//  Created by Saranvignesh Soundararajan on 09/08/22.
//

import UIKit

class FiveDaysTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var dayImgLbl: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var TempLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
