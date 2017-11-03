//
//  MapViewController.swift
//  JsonToMap
//
//  Created by André Niet on 26.10.17.
//  Copyright © 2017 André Niet. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var dataProvider = PlacemarksDataProvider()
    var placemarkViewModel: PlacemarkViewModel?
    var locationManager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load data
        DispatchQueue.main.async {
            self.dataProvider.requestData() { [weak self] (placemarkViewModel: PlacemarkViewModel?, errorMessage: String) in
                guard let placemarkViewModel = placemarkViewModel else {
                    print(errorMessage)
                    return
                }
                
                self?.placemarkViewModel = placemarkViewModel
                self?.addAnnotations()
            }
        }
        
        initializeLocationManager()
        configureMapView()
     }
    
    func initializeLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.startUpdatingLocation()
        }
    }

    fileprivate func configureMapView() {
        mapView.showsCompass = true
        mapView.showsTraffic = true
        mapView.userTrackingMode = .follow
        mapView.delegate = self
    }
    
    func addAnnotations() {
        placemarkViewModel?.placemarks.forEach { placemark in
            let placemarkAnnotation = PlacemarkAnnotation(name: placemark.name, coordinate: CLLocationCoordinate2DMake(placemark.coordinates[1], placemark.coordinates.first!))
            mapView.addAnnotation(placemarkAnnotation)
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        let reuseIdentifier = "MyIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
}

class PlacemarkAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let title: String?
    var subtitle: String?
    
    init(name: String, coordinate: CLLocationCoordinate2D) {
        self.title = name
        self.coordinate = coordinate
    }
    

}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotations = mapView.annotations
        let selectedAnnotation = view.annotation
        
        annotations.forEach { annotation in
            // Dont hide my location
            if annotation is MKUserLocation == false {
                // Hide all besides the selected annotation
                mapView.view(for: annotation)?.isHidden = annotation.title! != selectedAnnotation!.title!
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        // Show all on deselect
        mapView.annotations.forEach { annotation in
            mapView.view(for: annotation)?.isHidden = false
        }
    }
}
