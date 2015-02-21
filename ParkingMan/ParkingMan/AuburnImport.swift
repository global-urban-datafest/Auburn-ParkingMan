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

class AuburnImport: NSObject{
    class func get(){
        let urlPath: String = "http://www.auburnalabama.org/odata/ventek/stall"
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        let queue:NSOperationQueue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var err: NSError
            var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            println("AsSynchronous\(jsonResult)")
        })
        
    }
}