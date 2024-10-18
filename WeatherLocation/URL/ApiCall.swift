//
//  ApiCall.swift
//  WeatherLocation
//
//  Created by Saranvignesh Soundararajan on 11/08/22.
//

import Foundation
import CoreData
import UIKit


class ApiCall {
    static let shared = ApiCall()
    private init() {}
    
    // MARK: - Apicall function for getting weather data
    func makeApiCall(completionHandler: @escaping(Weather?, Error?) -> Void) {
        
        guard let url = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            let decoder = JSONDecoder()
                    if let data = data{
                        do{
                            let weatherHandler = try decoder.decode(Weather.self, from: data)
                            completionHandler(weatherHandler, nil)
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
                            models = try context.fetch(HistoryItem.fetchRequest())
                            print("removed modeal values",models)
                            
                        } catch {
                            // error
                            completionHandler(nil, error)
                            
                        }
                    }
    }
    task.resume()
    }

    
    // MARK: - Apicall function for getting next fivedays weather data
    func anotherApiCall(completionHandler: @escaping(_ response2: FiveDays) -> Void) {
        guard let url = URL(string: url1) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in

            let decoder = JSONDecoder()
                    if let data = data{
                        do{
                            let fivedaysHandler = try decoder.decode(FiveDays.self, from: data)
                            completionHandler(fivedaysHandler)
                        } catch {
                            // error
                            print(error)

                        }
                    }

    }
    task.resume()

    }
    
    
    
    // MARK: - Apicall function for checking user entered city is valid or not
    func checkApiCall(completionHandler: @escaping(Weather?, Error?) -> Void) {
        
        guard let url = URL(string: validCity) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            let decoder = JSONDecoder()
                    if let data = data{
                        do{
                            let checkHandler = try decoder.decode(Weather.self, from: data)
                            completionHandler(checkHandler, nil)
                            
                            
                        } catch {
                            // error
                            completionHandler(nil, error)
                            
                        }
                    }
    }
    task.resume()
    }


}

