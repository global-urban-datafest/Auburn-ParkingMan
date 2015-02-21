//
//  ViewController.swift
//  ParkingMan
//
//  Created by Richard Kosbab on 2/21/15.
//  Copyright (c) 2015 ParkingMan. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        AuburnImport.get()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

