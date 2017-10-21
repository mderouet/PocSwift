//
//  ViewController.swift
//  ApplicationSwift-Poizat-Derouet
//
//  Created by warp on 18/10/17.
//  Copyright © 2017 warp. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController{
    // Variables
    public var events:[Event] = [] //Full list of event
    public var eventDetail:Event = Event() //Clicked list event

    // Outlets
    @IBOutlet weak var mapView: MKMapView!
    // Variable
    let montpellierXCoordinate:CLLocationDegrees = 43.6109200
    let montpellierYCoordinate:CLLocationDegrees = 3.8772300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Loading a simple event (click detailevent) map zoomed, center on event value
        if Double(eventDetail.getX()) != nil && Double(eventDetail.getY()) != nil{
            spanZoom(latitudeDelta: 0.1, longitudeDelta: 0.1,centerX: Double(eventDetail.getX(()))!,centerY: Double(eventDetail.getY())!)
            loadMap(event: self.eventDetail)
        }
        //Loading all annotation map dezoomed a bit, center on montpellier
        else{
            spanZoom(latitudeDelta: 0.4, longitudeDelta: 0.4,centerX: montpellierXCoordinate,centerY: montpellierYCoordinate)
            loadMap(events: self.events)
        }
    }

    // Various implementation of annotation here (we will maybe add information on this annotation)
    func loadMap(event:Event){
        
        makeAnnotationOnMap(map: mapView, x: Double(event.getX())!, y: Double(event.getY())!, title: event.getTitre(), subtitle: event.getLieu())
    }
    
    func loadMap(events:[Event]){
        //Iterate over event array to create corresponding annotation on map

        for event in events{
            if Double(event.getX()) != nil && Double(event.getY()) != nil{
                makeAnnotationOnMap(map: mapView, x: Double(event.getX())!, y: Double(event.getY())!, title: event.getTitre(), subtitle: event.getLieu())
            }
        }
    }
    
    func spanZoom(latitudeDelta:CLLocationDegrees,longitudeDelta:CLLocationDegrees,centerX:CLLocationDegrees,centerY:CLLocationDegrees){
        //Setup map position
        let location = CLLocationCoordinate2DMake(centerX,centerY)
        let span = MKCoordinateSpanMake(latitudeDelta,longitudeDelta)
        let region = MKCoordinateRegion(center:location,span:span)
        mapView.setRegion(region,animated: true)
    }
    
    func makeAnnotationOnMap(map:MKMapView,x:CLLocationDegrees,y:CLLocationDegrees,title:String,subtitle:String){
        let location = CLLocationCoordinate2DMake(x, y)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = title
        annotation.subtitle = subtitle
        map.addAnnotation(annotation)
    }
    
    
    
}

