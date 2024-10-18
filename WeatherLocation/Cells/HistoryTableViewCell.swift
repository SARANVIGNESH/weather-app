//
//  HistoryTableViewCell.swift
//  WeatherLocation
//
//  Created by CSS on 22/07/22.
//

import UIKit



class HistoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var cityBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    
    
}
