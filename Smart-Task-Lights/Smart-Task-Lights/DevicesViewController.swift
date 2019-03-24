//
//  FirstViewController.swift
//  Smart-Task-Lights
//
//  Created by Kimberly Zhu on 3/23/19.
//  Copyright © 2019 UCB-Team-Tech. All rights reserved.
//

import UIKit

class DevicesViewController: UIViewController {
    
    @IBOutlet weak var energyConsumed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.energyConsumed.text = "textIWant"
    }


}

