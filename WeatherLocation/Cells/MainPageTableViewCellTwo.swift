//
//  MainPageTableViewCellTwo.swift
//  WeatherLocation
//
//  Created by Saranvignesh Soundararajan on 08/08/22.
//

import UIKit

class MainPageTableViewCellTwo: UITableViewCell {
    
    @IBOutlet weak var sunRiseLbl: UILabel!
    @IBOutlet weak var sunSetLbl: UILabel!
    
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    @IBOutlet weak var minTempVal: UILabel!
    
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var realFeelValLbl: UILabel!
    @IBOutlet weak var humidityVal: UILabel!
    @IBOutlet weak var realFellVal: UILabel!
    @IBOutlet weak var maxTempVal: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
