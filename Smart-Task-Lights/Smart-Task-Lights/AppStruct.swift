//
//  File.swift
//  Smart-Task-Lights
//
//  Created by Kimberly Zhu on 3/31/19.
//  Copyright © 2019 UCB-Team-Tech. All rights reserved.
//

import Foundation
import CoreLocation
import AVFoundation

struct UserData {
    static var userFirstName:String = "Kimberly"; //need to connect with user input from Settings
    static var userLastName:String = "Zhu";
    
    //maplocation stuff
    static var myLightLocations: [CLLocationCoordinate2D] = [];
}

struct global {
    static var energyConsumed:Int = 100;
}
