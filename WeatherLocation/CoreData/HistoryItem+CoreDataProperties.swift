//
//  HistoryItem+CoreDataProperties.swift
//  WeatherLocation
//
//  Created by Saranvignesh Soundararajan on 23/07/22.
//
//

import Foundation
import CoreData


extension HistoryItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryItem> {
        return NSFetchRequest<HistoryItem>(entityName: "HistoryItem")
    }

    @NSManaged public var cityname: String?
    @NSManaged public var date: Date?

}

extension HistoryItem : Identifiable {

}
