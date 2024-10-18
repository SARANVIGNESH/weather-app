//
//  SearchViewController.swift
//  WeatherLocation
//
//  Created by Saranvignesh Soundararajan on 11/08/22.
//

import UIKit
var validCity = ""

var validCityArray: Weather?

class SearchViewController: UIViewController {
    
    @IBOutlet weak var cityName: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    // keyboard handling when user taps on outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    // MARK: - action for when user clicked back button
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        let destinationViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainId") as! MainPageViewController
        self.navigationController?.pushViewController(destinationViewController, animated: true)

    }
    
    // MARK: - action for when user tapped history button
    @IBAction func showHistory(_ sender: UIBarButtonItem) {
        let destinationViewController = self.storyboard?.instantiateViewController(withIdentifier: "CityId") as! HistoryViewController
        self.navigationController?.pushViewController(destinationViewController, animated: true)

    }
    // MARK: -action for when user tapped search button
    @IBAction func searchAction(_ sender: UIButton) {
        
        if cityName.text!.isEmpty {
            openAlert(title: "Alert", message: "City name should not be empty", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                            print("Okay")
                        }])
            
        } else {
            print("the ciiiiity is \(cityName.text!)")
            validCity = "\(weatherBaseUrl)?q=\(cityName.text!)&appid=\(apiId)&units=metric"
            ApiCall.shared.checkApiCall {(response, error) in
                validCityArray = response
                //print("the check array is\(response)")
                //print("the check error is\(error)")
                if response != nil {
                    //print("the check array is\(response)")
                    DispatchQueue.main.async {
                        let destinationViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainId") as! MainPageViewController
                        destinationViewController.cityNames = self.cityName.text ?? ""
                        self.navigationController?.pushViewController(destinationViewController, animated: true)
                    }

                } else {
                    DispatchQueue.main.async {
                        self.cityName.text = ""
                        self.openAlert(title: "Alert", message: "Weather condition is not available for user entered location", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                            print("Okay")
                        }])
                        
                    }
                }
                
            }
            
            
            
            
        }
        
    }
    

    

}
