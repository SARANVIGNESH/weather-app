//
//  HistoryViewController.swift
//  WeatherLocation
//
//  Created by Saranvignesh Soundararajan on 11/08/22.
//

import UIKit
import CoreData
// creating array for storing data
var models = [HistoryItem]()


class HistoryViewController: UIViewController {
    
    // creating var for storing user entered keyword/location
    var cityNames = ""
    
    // creating var for storing navgation city
    var navCity = ""
        
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var historyTableview: UITableView!
    
    // MARK: - button action for when user clicked back button
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        let destinationViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainId") as! MainPageViewController
        self.navigationController?.pushViewController(destinationViewController, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableview.delegate = self
        historyTableview.dataSource = self
        getAllItems()
    }
    

    

}

// MARK: - Extension for history view controller
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let thisItem: HistoryItem!
        thisItem = models[indexPath.row]
        
        let cell = historyTableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HistoryTableViewCell
                
         //date formatter - "dd/MM/yyyy h:mm a"
        func getCurrentDate() -> String {
            let dateFormatter = DateFormatter()
             dateFormatter.dateFormat = "dd/MM/yyyy h:mm a"
            return dateFormatter.string(from: thisItem.date!)

        }
        
        cell.city.text = thisItem.cityname
        cell.date.text = "\(getCurrentDate())"
        
        cell.cityBtn.tag = indexPath.row
        cell.cityBtn.addTarget(self, action: #selector(HistoryViewController.onClickedMapButton(_:)), for: .touchUpInside)
        
        return cell
    }
    // MARK: - onclick button function for user touching city
    @objc func onClickedMapButton(_ sender: UIButton) {
        print("Tapped")
        let btnTag = sender.tag
        navCity = models[btnTag].cityname ?? ""


        let destinationViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainId") as! MainPageViewController
        destinationViewController.cityNames = navCity
        self.navigationController?.pushViewController(destinationViewController, animated: true)

    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            CGFloat(120)
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        historyTableview.deselectRow(at: indexPath, animated: true)
        print(models[indexPath.row].cityname!)
        let destinationViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainId") as! MainPageViewController
        destinationViewController.cityNames = models[indexPath.row].cityname!
        self.navigationController?.pushViewController(destinationViewController, animated: true)
                
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            let item = models[indexPath.row]
            deleteItem(item: item)



        }
    }
    
    // MARK: - getting all items from coredata
    func getAllItems() {
        do {
            models = try context.fetch(HistoryItem.fetchRequest())
            DispatchQueue.main.async {
                self.historyTableview.reloadData()
            }

        } catch {
            //error
        }

    }
    // MARK: - deleting items from coredata
    func deleteItem(item: HistoryItem) {
        context.delete(item)
        print("item value before deletion",item)
        do {
            try context.save()
            getAllItems()
        } catch {
            // error
        }
    }
    
}
