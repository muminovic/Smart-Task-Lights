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
    
    //first number is last seen, second number is power consumed in kWh
    static var lightInfo:[[Double]] = [[15,3],[260,1.5],[63, 7.2],[21, 5.2],[83,1.3],[29,4.6]];
    static var lightNames:[String] = ["Kimberly", "Katelyn", "Annabel", "Radhika", "Selma", "Michelle"];
    
    //maplocation stuff
    static var mylightLocations: [CLLocationCoordinate2D] = [];
}
