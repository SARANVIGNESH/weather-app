//
//  MainPageTableViewCellThree.swift
//  WeatherLocation
//
//  Created by Saranvignesh Soundararajan on 09/08/22.
//

import UIKit

class MainPageTableViewCellThree: UITableViewCell {

    @IBOutlet weak var fiveDaysTableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fiveDaysTableView.delegate = self
        fiveDaysTableView.dataSource = self
        //fiveDaysTableView.reloadData()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// MARK: - extension for mainpagetableviewcellthree
extension MainPageTableViewCellThree: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = fiveDaysTableView.dequeueReusableCell(withIdentifier: "Cell4", for: indexPath) as! FiveDaysTableViewCell
        //print(monthArr)
        //print(yearArr)
        //print(weekArr)
        let imgURL = "\(weatherImgUrl)\(imageArr[indexPath.row])@2x.png"
        cell.dayImgLbl.downloaded(from: imgURL)
        cell.dayLbl.text = "\(weekArr[indexPath.row])"
        cell.dateLbl.text = "\(dateArr[indexPath.row])"+" / "+"\(monthArr[indexPath.row])"
        //print(arr1?.list[indexPath.row].main.temp_min ?? "" as String)
        cell.TempLbl.text = "\(Int(minTemparr[indexPath.row]))°C"+" / "+"\(Int(maxTempArr[indexPath.row]))°C"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fiveDaysTableView.deselectRow(at: indexPath, animated: true)
                
    }
    
    
}
