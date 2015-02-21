//
//  ViewController.swift
//  ParkingMan
//
//  Created by Richard Kosbab on 2/21/15.
//  Copyright (c) 2015 ParkingMan. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var spots = [CityOfAuburn]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List of Auburn Spots"
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        AuburnImport.get()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return spots.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
            let spot = spots[indexPath.row]
            cell.textLabel!.text = spot.stallnumber.stringValue
            return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        println("ViewWillAppear")
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchrequest = NSFetchRequest(entityName: "CityOfAuburn")
        
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchrequest, error: &error) as [CityOfAuburn]?
        
        if let results = fetchedResults {
            println(results.count)
            spots = results
            self.tableView.reloadData()
        }
    }


}

