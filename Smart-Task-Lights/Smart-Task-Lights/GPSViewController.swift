//
//  GPSViewController.swift
//  Smart-Task-Lights
//
//  Created by Kimberly Zhu on 3/23/19.
//  Copyright © 2019 UCB-Team-Tech. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AVFoundation

class GPSViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var zoomToButton: UIButton!
    @IBOutlet weak var changeMapButton: UIButton!

    //map
    var mapping:CLLocationManager!
    var currentLocation: CLLocation?
    var zoomOrNot: Bool = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapping = CLLocationManager()
        mapping.delegate = self
        
        mapping.requestAlwaysAuthorization()
        
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        //Zoom to user location
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(viewRegion, animated: false)
        }
        
        self.mapping = locationManager
        
        DispatchQueue.main.async {
            self.mapping.startUpdatingLocation()
        }
        
        mapView.showsUserLocation = true
        
        global.mylightLocations.append(CLLocationCoordinate2D(latitude: 37.869514, longitude: -122.258879))
        global.mylightLocations.append(CLLocationCoordinate2D(latitude: 37.871997,  longitude: -122.259342))
        global.mylightLocations.append(CLLocationCoordinate2D(latitude: 37.874925,  longitude: -122.257678))
        global.mylightLocations.append(CLLocationCoordinate2D(latitude: 37.871231,  longitude: -122.259275))
        
        
    }
    
    
    //for refresh
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.display();
        //timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.display), userInfo: nil, repeats: true)
        zoomOrNot = true
    }
    
    //part of refresh
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //timer?.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //METHOD FOR WHOLE PAGE - GETS CALLED BY VIEW DID APPEAR
    func display(){
        displayLights();
        zoomToLocation()
    }
    
    func displayLights(){
        mapView.removeAnnotations(mapView.annotations)
        
        //adding annotations
        for index in 0..<global.mylightLocations.count {
            let annotation = MKPointAnnotation();
            annotation.coordinate = global.mylightLocations[index]
            annotation.title = "Light x"
            
            mapView.addAnnotation(annotation)
        }
        
        if(global.mylightLocations.count > 0){
            for index in 0...global.mylightLocations.count-1{
                let annotation = MKPointAnnotation();
                annotation.coordinate = global.mylightLocations[index]
                mapView.addAnnotation(annotation)
                print(global.mylightLocations)
            }
        }
    }
    
    func showAlert() {
        let alerts = UIAlertController(title: "Error", message: "Location Services are not enabled", preferredStyle: .alert)
        alerts.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alerts.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (action:UIAlertAction!) -> Void in
            self.mapping.requestAlwaysAuthorization()
        }))
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as! CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        var region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        region.center = mapView.userLocation.coordinate
        mapView.setRegion(region, animated: true)
    }
    
    func zoomToLocation() {
        if let currentLocation = currentLocation {
            let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
            let region = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
            mapView.setRegion(region, animated: true)
            print("zoom to location")
        }
    }
    
}
