//
//  MapVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/9.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    var gym = Gym()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(gym.location, completionHandler: { placemarks, error in
            if let error = error {
                print(error)
                return
            }
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                let annotation = MKPointAnnotation()
                annotation.title = self.gym.name
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        })
        
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyMarker"
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        var annotationView: MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        annotationView?.glyphText = "💪"
        annotationView?.markerTintColor = UIColor.orange
        return annotationView
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
