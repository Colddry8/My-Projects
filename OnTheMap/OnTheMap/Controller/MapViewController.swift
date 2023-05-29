//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Денис Глущенко on 17/5/2566 BE.
//
import Foundation
import UIKit
import MapKit

// MARK: MapViewController
class MapViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: MapViewControllerOutlet
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.delegate = self
        showMapAnnotations(StudentModel.data)
    }
        
    // MARK: viewDidload
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            self.mapView.delegate = self
            }
    
    // MARK: setupMap
    func setupMap() {
        mapView.mapType = .standard
        mapView.isRotateEnabled = true
    }
    
    // MARK: mapView
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKMarkerAnnotationView
        
        if pinView == nil {
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView?.markerTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    // MARK: mapViewCalloutAccessoryControlTapped
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        if control == view.rightCalloutAccessoryView
        {
            if let ann = view.annotation {
                if let subt = ann.subtitle {
                    if let toOpen = subt
                    {
                        if let to = URL(string: toOpen) {
                            UIApplication.shared.open(to, options: [:], completionHandler: nil)
                        }
                    }
                }
            }
        }
    }
    
    

    // MARK: showMapAnnotation
    func showMapAnnotations(_ locations: [StudentLocation]) {
        DispatchQueue.main.async {
            var annotations = [MKPointAnnotation]()
            
            for location in locations {
                let latitude = CLLocationDegrees(location.latitude)
                let longitude = CLLocationDegrees(location.longitude)
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                
                let firstName = location.firstName
                let lastName = location.lastName
                let mediaURL = location.mediaURL
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(firstName) \(lastName)"
                annotation.subtitle = mediaURL
                
                annotations.append(annotation)
            }
        
            self.mapView.addAnnotations(annotations)
        }
    }
    
    
    
    // MARK: handleLogoutResponse
    func handleLogoutResponse(success: Bool, error: Error?) {
        if success {
            self.dismiss(animated: true, completion: nil)
        } else {
            showFailure(title: "Logout Failed", message: error?.localizedDescription ?? "")
        }
    }
        
    // MARK: IBAction logout
        @IBAction func logout(_ sender: Any) {
            UdacityClient.logout(completion: handleLogoutResponse(success:error:))
        }
    
    // MARK: IBAction refresh
    @IBAction func refresh(_ sender: Any) {
        UdacityClient.getStudentInformation(completion: handleGetStudentInformation(data:error:))
        DispatchQueue.main.async {
            if self.mapView.annotations.count > 0 {
                self.mapView.removeAnnotations(self.mapView.annotations)
                self.showMapAnnotations(StudentModel.data)
            }
        }
    }
    
    // MARK: IBAction addPinLocation
    @IBAction func addPinLocation(_ sender: Any) {
        let addPinVC =
            storyboard?.instantiateViewController(withIdentifier: "addLocation") as! AddPinViewController
            present(addPinVC, animated: true, completion: nil)
    }
    
    // MARK: HandleGetStudentInformation
    func handleGetStudentInformation(data: [StudentLocation], error: Error?)
    {
        if error == nil
        {
            StudentModel.data = data
        } else
        {
            showFailure(title: "Location Data error", message: error?.localizedDescription ?? "")
        }
    }
}
