//
//  MapViewController.swift
//  BanoBuddy
//
//  Created by Chandler Griffin on 3/20/17.
//  Copyright © 2017 BanoBuddy. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        if (CLLocationManager.locationServicesEnabled())    {
//            print("user")
//            let locationManager = CLLocationManager()
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.requestWhenInUseAuthorization()
//            locationManager.startUpdatingLocation()
//        }   else    {
            let gainesvilleRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(29.651634, -82.324826),MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            self.map.setRegion(gainesvilleRegion, animated: true)
//        }
        
        pinBathroom(latitude: 29.64, longitude: -82.2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as! CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let userRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
        self.map.setRegion(userRegion, animated: true)
    }
    
    func pinBathroom(latitude: NSNumber, longitude: NSNumber) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(latitude), CLLocationDegrees(longitude))
        annotation.title = String(describing: latitude)
        self.map.addAnnotation(annotation)
        self.map.delegate = self
        
        centerOnPin(annotation: annotation)
    }
    
    func findClosestBathroom()  {
        
    }
    
    func centerOnPin(annotation: MKPointAnnotation)  {
        var track = CLLocationCoordinate2D()
        track.latitude = annotation.coordinate.latitude
        track.longitude = annotation.coordinate.longitude
        
        var region = MKCoordinateRegion()
        var span = MKCoordinateSpan()
        span.latitudeDelta = 0.1
        span.longitudeDelta = 0.1
        region.span = span
        region.center = track
        
        self.map.setRegion(region, animated: true)
        self.map.regionThatFits(region)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
