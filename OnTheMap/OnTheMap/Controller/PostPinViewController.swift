//
//  PostPinViewController.swift
//  OnTheMap
//
//  Created by Денис Глущенко on 19/5/2566 BE.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

// MARK: PostPinViewController
class PostPinViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: PostPinViewControllerOutlets
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: PostPinViewControllerVariables
    var coordinates: CLLocationCoordinate2D!
    var location: String!
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        addAnnotation()
        submitButton.isEnabled = false
        linkTextField.delegate = self
    }
    
    // MARK: cancelButoon
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: submit
    @IBAction func submit(_ sender: Any) {
        uploadPinHelper(coordinates: coordinates, location: location, mediaURL: linkTextField.text!)
    }
    
    // MARK: addAnnotation
    func addAnnotation() {
        var annotations = [MKPointAnnotation]()
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotations.append(annotation)
        self.mapView.addAnnotations(annotations)
        
        let region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        
        self.mapView.setRegion(region, animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submit))
    }
    
    // MARK: uploadPinHelper
    func uploadPinHelper(coordinates: CLLocationCoordinate2D, location: String, mediaURL: String) {
        // load user's name
        UdacityClient.postStudentInformation(mapString: location, mediaURL: mediaURL, latitude: coordinates.latitude, longitude: coordinates.longitude, completion: handlePostStudentInformationResponse(success:error:))
    }
    
    // MARK: handlePostStudentInformation
    func handlePostStudentInformationResponse(success: Bool, error: Error?) {
            if success
            {
                DispatchQueue.main.async {
                    print("Success")
                    self.navigationController?.dismiss(animated: true)
                }
            } else
            {
                showFailure(title: "Post location error",message: error?.localizedDescription ?? "")
            }
    }
    
    
    // MARK: textFieldDidBeginEditing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "Enter your link here"{
            textField.text = ""
        }
    }
   
    // MARK: textFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // MARK: textFieldDidEndEditing
        func textFieldDidEndEditing(_ textField: UITextField) {
            if linkTextField.text != "" {
                submitButton.isEnabled = true
            }
        }
}
