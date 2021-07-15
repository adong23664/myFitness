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
        self.navigationController?.navigationBar.tintColor = .systemBlue
        
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
    
    @IBAction func showMeWhere(_ sender: Any) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(gym.location, completionHandler: {(placemarks:[CLPlacemark]!,error:Error!) in
            if error != nil{
                print(error!)
                return
            }
            if placemarks != nil && placemarks.count > 0{
                let placemark = placemarks[0] as CLPlacemark
                print("\(placemark.location?.coordinate.latitude ?? 0.0),\(placemark.location?.coordinate.longitude ?? 0.0)")
                let latitude: CLLocationDegrees = placemark.location?.coordinate.latitude ?? 0.0
                let longitude: CLLocationDegrees = placemark.location?.coordinate.longitude ?? 0.0
                let regionDistance: CLLocationDistance = 1000;
                let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
                let regionSpan = MKCoordinateRegion.init(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
                let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
                
                let placemark123 = MKPlacemark(coordinate: coordinates)
                let mapItem = MKMapItem(placemark: placemark123)
                mapItem.name = self.gym.name
                mapItem.openInMaps(launchOptions: options)
            }
        })
        

        
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
