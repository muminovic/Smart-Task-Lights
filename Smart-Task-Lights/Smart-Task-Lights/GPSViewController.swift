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
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch (status) {
        case .notDetermined, .denied, .restricted:
            showAlert()
        case .authorizedAlways:
            mapping.startUpdatingLocation()
        default:
            print("this is the default")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first
        if(zoomOrNot == true){
            zoomToLocation()
            zoomOrNot = false
        }
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
