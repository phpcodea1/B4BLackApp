//
//  MapLocaitonViewControlller.swift
//  B4Black
//
//  Created by eWeb on 13/06/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapLocaitonViewControlller: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate
{

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsScale = true
        mapView.showsPointsOfInterest = true
        mapView.showsUserLocation = true
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
        }
        
    }
    
    @IBAction func GoBackAct(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
        
    }
