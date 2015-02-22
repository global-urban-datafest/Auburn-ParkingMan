//
//  AuburnImport.swift
//  ParkingMan
//
//  Created by Richard Kosbab on 2/21/15.
//  Copyright (c) 2015 ParkingMan. All rights reserved.
//

import Foundation
import CoreData
import UIKit
@objc(CityOfAuburn)

class AuburnImport: NSObject{
    
    class func get(view: UIView){
        let urlPath: String = "http://www.auburnalabama.org/odata/ventek/stall"
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        let queue:NSOperationQueue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var err: NSError
            AuburnImport.CoreDataImport(data, view: view)
        })
    }
    
    class func CoreDataImport(data: NSData, view: UIView){
        let auburnJSON = JSON(data: data)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        for (index:String, subJson:JSON) in auburnJSON["value"]{
            var spot: CityOfAuburn!
            let fetchRequest = NSFetchRequest(entityName: "CityOfAuburn")
            let predicate = NSPredicate(format: "stallnumber == %i", subJson["StallNumber"].int!)
            fetchRequest.predicate = predicate
            let fetchResults = managedContext.executeFetchRequest(fetchRequest, error: nil)!
            if (!fetchResults.isEmpty){
                spot = fetchResults[0] as CityOfAuburn
            } else {
                spot = NSEntityDescription.insertNewObjectForEntityForName("CityOfAuburn", inManagedObjectContext: managedContext) as CityOfAuburn
            }
            
            // Import the Data
            spot.id = subJson["ID"].int!
            spot.lotid = subJson["LotID"].int!
            spot.stallnumber = subJson["StallNumber"].int!
            spot.starttime = dateFormatter.dateFromString(subJson["StartTime"].string!)!
            spot.expirationtime = dateFormatter.dateFromString(subJson["ExpirationTime"].string!)!
            spot.occupidetime = dateFormatter.dateFromString(subJson["OccupiedTime"].string!)!
            spot.occupied = subJson["Occupied"].boolValue
            spot.x_coord = subJson["X_Coord"].doubleValue
            spot.y_coord = subJson["Y_Corrd"].doubleValue
            spot.stalltype = subJson["StallType"].string!
            
        }
        dispatch_async(dispatch_get_main_queue(), {
            view.setNeedsLayout()
            println("reload")
        })
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
    }
}