//
//  MainPageTableViewCellOne.swift
//  WeatherLocation
//
//  Created by Saranvignesh Soundararajan on 08/08/22.
//

import UIKit

class MainPageTableViewCellOne: UITableViewCell {

    @IBOutlet weak var imgLbl: UIImageView!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
