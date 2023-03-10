//
//  Map.swift
//  CARCONNECT
//
//  Created by MAC923_47 on 12/11/2562 BE.
//  Copyright © 2562 carconnect.ac.th. All rights reserved.
//

import UIKit
import MapKit

class Map: UIViewController,CLLocationManagerDelegate ,MKMapViewDelegate{

    var m_location = CLLocationManager()
    @IBOutlet weak var speedH: UILabel!
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let myLocation: CLLocation = locations[0] as CLLocation
        let latitude: CLLocationDegrees = myLocation.coordinate.latitude
        let longtitude: CLLocationDegrees = myLocation.coordinate.longitude
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01)
        let location = CLLocationCoordinate2DMake(latitude, longtitude)
        
        let region = MKCoordinateRegion(center: location,span: span)
        mapView.setRegion(region, animated: true)
        
        let speed = myLocation.speed * 3.6
        speedH.text = "\(speed) km/h"
    }
    
    func GoToCenterLocation()
    {
        if let locman = m_location.location
        {
            let region = MKCoordinateRegion(center: locman.coordinate,latitudinalMeters: 400,longitudinalMeters: 400)
            mapView.setRegion(region, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        m_location.delegate = self
        m_location.desiredAccuracy = kCLLocationAccuracyBest
        mapView.delegate = self
        
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse && CLLocationManager.authorizationStatus() != .authorizedAlways
        {
            m_location.requestWhenInUseAuthorization()
        }
        mapView.showsUserLocation = true
        m_location.startUpdatingLocation()

    }
    @IBOutlet weak var mapView: MKMapView!

}
