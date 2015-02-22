//
//  ViewController.swift
//  ParkingMan
//
//  Created by Richard Kosbab on 2/21/15.
//  Copyright (c) 2015 ParkingMan. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class ViewController: UIViewController{
    @IBOutlet weak var mapView: MKMapView!
    
    var spots = [CityOfAuburn]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Location of smart parking deck
        let location = CLLocationCoordinate2D(latitude: 32.607437, longitude: -85.480376)
        
        // Controlls inital Size
        let span = MKCoordinateSpanMake(0.0005, 0.0005)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.mapType = MKMapType.Satellite
        mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        spots = getSpots()
        var annotations = Array<MKPointAnnotation>()
        for spot in spots{
            let annotation = MKPointAnnotation()
            println(spot.y_coord.doubleValue)
            let spotcoords = CLLocationCoordinate2D(latitude: spot.y_coord.doubleValue, longitude: spot.x_coord.doubleValue)
            annotation.coordinate = spotcoords
            annotation.title = spot.stallnumber.stringValue
            annotation.subtitle = "Open"
            annotations.append(annotation)
        }
        println(annotations.count)
        mapView.addAnnotations(annotations)
        AuburnImport.get(self.view)
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
    }
    
    func getSpots() -> Array<CityOfAuburn> {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchrequest = NSFetchRequest(entityName: "CityOfAuburn")
        let predicate = NSPredicate(format: "occupied == NO")
        var error: NSError?
        fetchrequest.predicate = predicate
        let fetchedResults = managedContext.executeFetchRequest(fetchrequest, error: &error) as [CityOfAuburn]?
        if let results = fetchedResults {
            println(results.count)
            spots = results
        }
        
    return spots
    }
    
}

