//
//  MainPageViewController.swift
//  WeatherLocation
//
//  Created by Saranvignesh Soundararajan on 07/08/22.
//

import UIKit
import CoreLocation
import CoreData
// creating object for storing weather api data
var weatherArr: Weather?
// creating object for storing next 5 days weather api data
var fiveDaysArr: FiveDays?
// craeting array for storing next 5 days dates
var dateArr: [Int] = []
// craeting array for storing next 5 days months
var monthArr: [Int] = []
// craeting array for storing next 5 days years
var yearArr: [Int] = []
// craeting array for storing next 5 days maximum temperature
var maxTempArr: [Double] = []
// craeting array for storing next 5 days minimum temperature
var minTemparr: [Double] = []
// craeting array for storing next 5 days day value
var weekArr: [String] = []
// craeting array for storing next 5 days weather images
var imageArr: [String] = []
// storing url based on user input condition
var url = ""
// storing url based on user input condition
var url1 = ""
// storing api key in variable
var apiId = "9c9e38a6cdb9f0fbd0184970bcfb8363"







class MainPageViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var navTitle: UINavigationItem!
    // MARK: - button action for when user clicked search button
    @IBAction func showSearch(_ sender: UIBarButtonItem) {
        let destinationViewController = self.storyboard?.instantiateViewController(withIdentifier: "HistoryId") as! SearchViewController
        self.navigationController?.pushViewController(destinationViewController, animated: true)
        
    }
    // MARK: - button action for when user clicked history button
    @IBAction func showHistory(_ sender: UIBarButtonItem) {
        let destinationViewController = self.storyboard?.instantiateViewController(withIdentifier: "CityId") as! HistoryViewController
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    // creating var for storing user entered keyword/location
    var cityNames = ""
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
                
        if cityNames != "" {
            navTitle.title = "\(cityNames)"
        } else {
            navTitle.title = "San Francisco"
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }

    func setupLocation() {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil  {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    // MARK: - function for requesting weather location
    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else {
            return
        }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude

        print(lat)
        print(long)

        if cityNames == "" {
            url = "\(weatherBaseUrl)?lat=\(lat)&lon=\(long)&appid=\(apiId)&units=metric"

        } else {
            url = "\(weatherBaseUrl)?q=\(cityNames.localizedLowercase)&appid=\(apiId)&units=metric"
        }

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

        
        // MARK: -  making api call for current weather condition for device coordinates or user entered keyword/location
        
        ApiCall.shared.makeApiCall {(response, error) in
            
            weatherArr = response
            
//            if error != nil {
//
//                DispatchQueue.main.async {
//                    self.openAlert(title: "Alert", message: "Weather condition is not available for user entered location", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
//                        print("Okay")
//
//                        let destinationViewController = self.storyboard?.instantiateViewController(withIdentifier: "HistoryId") as! SearchViewController
//
//                        self.navigationController?.pushViewController(destinationViewController, animated: true)
//                    }])
//
//                }
//
//            }
            if response != nil {
                if self.cityNames != "" {
                    
                        var count=0
                        for i in 0..<models.count {
                            print(models[i].cityname!)
                            if(models[i].cityname! == self.cityNames){
                                print("yes",i,models[i].cityname!)
                                if(i==0){
                                    count = -1
                                }
                                else{
                                    count=i

                                }
                            }
                        }
        //              print("value of count",count,models[count])
                        if(count == 0){
                            print("no action neededß",self.cityNames)
                        }
                        else{
                            if(count == -1){
                                count=0
                            }
                            context.delete(models.remove(at: count))
                            print("deleted")
                        }
                        let entity = NSEntityDescription.entity(forEntityName: "HistoryItem", in: context)
                        let newItem = HistoryItem(entity: entity!, insertInto: context)
                        newItem.cityname = self.cityNames
                        newItem.date = Date()

                        do{
                            try context.save()
                            //models.append(newItem)

                        } catch {
                            // error

                        }
                    }
            }
            
                
            
                
            
                
              
            
        }
//        ApiCall.shared.makeApiCall {(response) in
//                weatherArr = response
//                if self.cityNames != "" {
//                    models = try context.fetch(HistoryItem.fetchRequest())
//                    print("removed modeal values",models)
//                    var count=0
//                    for i in 0..<models.count {
//                        print(models[i].cityname!)
//                        if(models[i].cityname! == self.cityNames){
//                            print("yes",i,models[i].cityname!)
//                            if(i==0){
//                                count = -1
//                            }
//                            else{
//                                count=i
//
//                            }
////                                      break;
//                        }
//                    }
//////                                print("value of count",count,models[count])
//                    if(count == 0){
//                        print("no action neededß",self.cityNames)
//                    }
//                    else{
//                        if(count == -1){
//                            count=0
//                        }
//                        context.delete(models.remove(at: count))
//                        print("deleted")
//                    }
//
////                                models = try context.fetch(HistoryItem.fetchRequest())
////                                print("removed modeal values",models)
//                    let entity = NSEntityDescription.entity(forEntityName: "HistoryItem", in: context)
//                    let newItem = HistoryItem(entity: entity!, insertInto: context)
//                    newItem.cityname = self.cityNames
//                    newItem.date = Date()
//
//                    do{
//                        try context.save()
//                        //models.append(newItem)
//
//                    } catch {
//                        // error
//
//                    }
//
//                }
//
//                DispatchQueue.main.async {
//                    self.weatherTableView.reloadData()
//
//                }
//
//        }
        if cityNames == "" {
            url1 = "\(fivedaysBaseUrl)?lat=\(lat)&lon=\(long)&appid=\(apiId)&units=metric"

        } else {
            url1 = "\(fivedaysBaseUrl)?q=\(cityNames.localizedLowercase)&appid=\(apiId)&units=metric"
        }
        // MARK: - making api call for next 5 days weather condition for device coordinates or user entered keyword/location
        ApiCall.shared.anotherApiCall {(response) in
            fiveDaysArr = response
            var d:[Int] = []
            var m: [Int] = []
            var y: [Int] = []
            var minT:[Double] = []
            var maxT:[Double] = []
            var weeks: [String] = []
            var images: [String] = []
            let cnt = fiveDaysArr?.list.count ?? 0 as Int
            func getDayOfWeek(_ date:String, format: String) -> String? {

                let weekDays = [
                    "Sunday",
                    "Monday",
                    "Tuesday",
                    "Wednesday",
                    "Thursday",
                    "Friday",
                    "Saturday"
                ]

                let formatter  = DateFormatter()
                formatter.dateFormat = format
                guard let myDate = formatter.date(from: date) else { return nil }

                let myCalendar = Calendar(identifier: .gregorian)
                let weekDay = myCalendar.component(.weekday, from: myDate)


                return weekDays[weekDay-1]
            }



            for i in 0..<cnt{

                let dateTime = fiveDaysArr?.list[i].dt_txt ?? "" as String
                let ans = dateTime.components(separatedBy: " ")
                //print(type(of: ans[0]))
                let dobArr = ans[0].components(separatedBy: "-")


                let t = (Int(dobArr.last ?? "") ?? 0)
                let t1 = Int(dobArr[1] ) ?? 0
                let t2 = Int(dobArr[0] ) ?? 0
                let t3 = fiveDaysArr?.list[i].main.temp_min ?? 0
                let t4 = fiveDaysArr?.list[i].main.temp_max ?? 0
                let weekday = getDayOfWeek(ans[0], format:"yyyy-MM-dd")
                let img = fiveDaysArr?.list[i].weather[0].icon ?? "" as String
                //print(weekday)

                // duplicating dates
                if d.contains(t){
                    continue

                } else if d.count < 5{
                    d.append(t)
                    m.append(t1)
                    y.append(t2)
                    minT.append(t3)
                    maxT.append(t4)
                    weeks.append(weekday ?? "")
                    images.append(img)


                }

            }
            //print(weeks)
            weeks[0] = "Today"
            weeks[1] = "Tomorrow"
            //print(weeks)
            dateArr = d
            monthArr = m
            yearArr = y
            minTemparr = minT
            maxTempArr = maxT
            weekArr = weeks
            imageArr = images
            DispatchQueue.main.async {
                self.weatherTableView.reloadData()

            }

        }
        
//        guard let url = URL(string: url) else {
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url){
//            data, response, error in
//
//            let decoder = JSONDecoder()
//                    if let data = data{
//
//                        do{
//
//                            weatherArr = try decoder.decode(Weather.self, from: data)
//                            if self.cityNames != "" {
//                                models = try context.fetch(HistoryItem.fetchRequest())
//                                print("removed modeal values",models)
//                                var count=0
//                                for i in 0..<models.count {
//                                    print(models[i].cityname!)
//                                    if(models[i].cityname! == self.cityNames){
//                                        print("yes",i,models[i].cityname!)
//                                        if(i==0){
//                                            count = -1
//                                        }
//                                        else{
//                                            count=i
//
//                                        }
////                                      break;
//                                    }
//                                }
////                                print("value of count",count,models[count])
//                                if(count == 0){
//                                    print("no action neededß",self.cityNames)
//                                }
//                                else{
//                                    if(count == -1){
//                                        count=0
//                                    }
//                                    context.delete(models.remove(at: count))
//                                    print("deleted")
//                                }
//
////                                models = try context.fetch(HistoryItem.fetchRequest())
////                                print("removed modeal values",models)
//                                let entity = NSEntityDescription.entity(forEntityName: "HistoryItem", in: context)
//
//                                let newItem = HistoryItem(entity: entity!, insertInto: context)
//
//                                newItem.cityname = self.cityNames
//                                newItem.date = Date()
//
//
//                                do{
//                                    try context.save()
//                                    models = try context.fetch(HistoryItem.fetchRequest())
//                                    //print(models.count)
//                                    print("the sjhdsjdjn is\(models)")
////                                    for i in 0..<models.count {
////                                        print(models[i].cityname!)
////                                    }
//                                    //print(models.remove(at: 3))
//                                    //print(models.count)
////                                    models.removeAll();
//
////                                    context.delete(models.remove(at: count))
////                                    print("value of count",count)
//
////                                    print("models after update of count",models)
//////                                    models.append(newItem)
////                                    print("model values after update",models)
//
//                                } catch {
//                                    // error
//                                }
//
//                            }
//
//                            //self.navTitle.title = self.arr?.name ?? "" as String
//
//                            DispatchQueue.main.async {
//                                self.weatherTableView.reloadData()
//
//
//                            }
//                        }catch{
//                            DispatchQueue.main.async {
//                                self.openAlert(title: "Alert", message: "Weather condition is not available for user entered location", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
//                                    print("Okay")
//
//                                    let destinationViewController = self.storyboard?.instantiateViewController(withIdentifier: "HistoryId") as! SearchViewController
//
//                                    self.navigationController?.pushViewController(destinationViewController, animated: true)
//                                }])
//
//                            }
//
//
//                        }
//                    }
//        }
//        task.resume()


//        if cityNames == "" {
//            url1 = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(long)&appid=\(apiId)&units=metric"
//
//        } else {
//            url1 = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityNames.localizedLowercase)&appid=\(apiId)&units=metric"
//        }


//        guard let newurl = URL(string: url1) else {
//            return
//        }
//        let task1 = URLSession.shared.dataTask(with: newurl){
//            data, response, error in
//            let decoder = JSONDecoder()
//                    if let data = data{
//
//                        do{
//                            fiveDaysArr = try decoder.decode(FiveDays.self, from: data)
//                            //print(self.arr1)
//
//                            var d:[Int] = []
//                            var m: [Int] = []
//                            var y: [Int] = []
//                            var minT:[Double] = []
//                            var maxT:[Double] = []
//                            var weeks: [String] = []
//                            var images: [String] = []
//                            let cnt = fiveDaysArr?.list.count ?? 0 as Int
//                            func getDayOfWeek(_ date:String, format: String) -> String? {
//
//                                let weekDays = [
//                                    "Sunday",
//                                    "Monday",
//                                    "Tuesday",
//                                    "Wednesday",
//                                    "Thursday",
//                                    "Friday",
//                                    "Saturday"
//                                ]
//
//                                let formatter  = DateFormatter()
//                                formatter.dateFormat = format
//                                guard let myDate = formatter.date(from: date) else { return nil }
//
//                                let myCalendar = Calendar(identifier: .gregorian)
//                                let weekDay = myCalendar.component(.weekday, from: myDate)
//
//
//                                return weekDays[weekDay-1]
//                            }
//
//
//
//                            for i in 0..<cnt{
//
//                                let dateTime = fiveDaysArr?.list[i].dt_txt ?? "" as String
//                                let ans = dateTime.components(separatedBy: " ")
//                                //print(type(of: ans[0]))
//                                let dobArr = ans[0].components(separatedBy: "-")
//
//
//                                let t = (Int(dobArr.last ?? "") ?? 0)
//                                let t1 = Int(dobArr[1] ) ?? 0
//                                let t2 = Int(dobArr[0] ) ?? 0
//                                let t3 = fiveDaysArr?.list[i].main.temp_min ?? 0
//                                let t4 = fiveDaysArr?.list[i].main.temp_max ?? 0
//                                let weekday = getDayOfWeek(ans[0], format:"yyyy-MM-dd")
//                                let img = fiveDaysArr?.list[i].weather[0].icon ?? "" as String
//                                //print(weekday)
//
//                                // duplicating dates
//                                if d.contains(t){
//                                    continue
//
//                                } else if d.count < 5{
//                                    d.append(t)
//                                    m.append(t1)
//                                    y.append(t2)
//                                    minT.append(t3)
//                                    maxT.append(t4)
//                                    weeks.append(weekday ?? "")
//                                    images.append(img)
//
//
//                                }
//
//                            }
//                            //print(weeks)
//                            weeks[0] = "Today"
//                            weeks[1] = "Tomorrow"
//                            //print(weeks)
//                            dateArr = d
//                            monthArr = m
//                            yearArr = y
//                            minTemparr = minT
//                            maxTempArr = maxT
//                            weekArr = weeks
//                            imageArr = images
//
//                            DispatchQueue.main.async{
//                                self.weatherTableView.reloadData()
//
//                            }
//                        }catch{
//                            print(error)
//
//                        }
//                    }
//       }
//       task1.resume()
    }
    
    
    

}

// MARK: - extension for mainpageviewcontroller
extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = weatherTableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath as IndexPath) as! MainPageTableViewCellOne
            let img = weatherArr?.weather[indexPath.row].icon ?? "" as String
            let imgURL = "\(weatherImgUrl)\(img)@2x.png"
            print(imgURL)
            cell.imgLbl.downloaded(from: imgURL)
            cell.tempLbl.text = "\(Int(weatherArr?.main.temp ?? 0 as Double))°C"
            
            
            //cell.topTemp.font = UIFont(name: "Helvetica-Bold", size: 50)
            cell.descLbl.text = "\(weatherArr?.weather[indexPath.row].description ?? "" as Any)"
            //print(arr ?? "" as Any)
            //print(arr?.weather[indexPath.row].icon ?? "" as String)
            return cell
        }
        else if indexPath.row == 1  {
            let cell = weatherTableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath as IndexPath) as! MainPageTableViewCellTwo
            let dblSunrise = weatherArr?.sys.sunrise ?? Int(0 as Double)
            let dblSunset = weatherArr?.sys.sunset ?? Int(0 as Double)
            
            let riseTime = NSDate(timeIntervalSince1970: TimeInterval(dblSunrise))
            let setTime = NSDate(timeIntervalSince1970: TimeInterval(dblSunset))
            
            func getSunrise() -> String {
                let dateFormatter = DateFormatter()
                 dateFormatter.dateFormat = "h:mm a"
                return dateFormatter.string(from: riseTime as Date)

            }
            
            func getSunset() -> String {
                let dateFormatter = DateFormatter()
                 dateFormatter.dateFormat = "h:mm a"
                return dateFormatter.string(from: setTime as Date)

            }
            
            cell.sunRiseLbl.text = "Sunrise \(getSunrise())"
            cell.sunSetLbl.text = "Sunset \(getSunset())"
            cell.minTempLbl.text = "Min temp"
            cell.maxTempLbl.text = "Max Temp"
            cell.minTempVal.text = "\(weatherArr?.main.temp_min ?? "" as Any) °C"
            cell.maxTempVal.text = "\(weatherArr?.main.temp_max ?? "" as Any) °C"
            cell.realFeelValLbl.text = "Real Feel"
            cell.humidityLbl.text = "Humidity"
            cell.realFellVal.text = "\(weatherArr?.main.feels_like ?? "" as Any) °C"
            cell.humidityVal.text = "\(weatherArr?.main.humidity ?? "" as Any) %"
            return cell
        }
        else {
            
            let cell = weatherTableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath as IndexPath) as! MainPageTableViewCellThree
            cell.fiveDaysTableView.reloadData()
            
            return cell
                
            
            
            
            

            
        }
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(250)
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        weatherTableView.deselectRow(at: indexPath, animated: true)
                
    }

    
}

// MARK: - extension for fetching url image api
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

