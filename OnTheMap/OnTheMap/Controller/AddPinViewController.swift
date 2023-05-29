//
//  AddPinViewController.swift
//  OnTheMap
//
//  Created by Денис Глущенко on 18/5/2566 BE.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

// MARK: AddPinViewController
class AddPinViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate  {
    
    // MARK: AddPinViewControllerOutlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var acceptButton: UIButton!
    var coordinates: CLLocationCoordinate2D!
    var mapString: String!
    var locationManager: CLLocationManager!
    
    // MARK:  viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationTextField.text = "Enter your location here"
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        acceptButton.isEnabled = false
        locationTextField.delegate = self
    }
    
    // MARK: cancellButton
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: accept
    @IBAction func accept(_ sender: Any) {
        mapString = locationTextField.text
        setFindingLocation(true)
        getCoordinate(addressString: mapString, completion: handleGetCoordinates(location:error:))
    }
    
    func setFindingLocation(_ findingLocation: Bool)
    {
        findingLocation ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        
        locationTextField.isEnabled = !findingLocation
        acceptButton.isEnabled = !findingLocation
    }
    
    // MARK: getCoordinate
    func getCoordinate(addressString: String, completion: @escaping(CLLocationCoordinate2D, NSError?) -> Void)
    {
        print("Calling Get Coordinate with \(addressString)")
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil
            {
                if let placemark = placemarks?[0]
                {
                    if let location = placemark.location
                    {
                        self.coordinates = location.coordinate
                        if self.locationTextField.text == ""
                        {
                            self.showFailure(title: "Missing Field", message: "Location is Empty")
                            self.setFindingLocation(false)
                        }
                        completion(location.coordinate, nil)
                    }
                }
            } else
            {
                completion(kCLLocationCoordinate2DInvalid, error as NSError?)
            }
        }
    }
    
    // MARK: shouldPerformSegue
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "acceptPin"
        {
            if self.coordinates == nil
            {
                return false
            }
        }
        if self.locationTextField.text == ""
        {
            return false
        }
        return true
    }
    
    // MARK: handleGetCoordinates
    func handleGetCoordinates(location: CLLocationCoordinate2D, error: NSError?)
    {
        
        if let _ = error
        {
            showFailure(title: "Location Error", message: "there was an error in finding that location")
            setFindingLocation(false)
            
        } else
        {
            setFindingLocation(false)
            performSegue(withIdentifier: "acceptPin", sender: nil)
        }
    }
    
    // MARK: prepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let destination = segue.destination as! PostPinViewController
        destination.coordinates = coordinates
        destination.location = mapString
       
    }
    
    // MARK: textFieldDidBeginEditing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == locationTextField && textField.text == "Enter your location here" { textField.text = ""
        }
    }
    
    // MARK: textFieldDidEndEditing
    func textFieldDidEndEditing(_ textField: UITextField) {
        if locationTextField.text != "" && locationTextField.text != "Enter your location here" {
            acceptButton.isEnabled = true
        }
    }
    
   
    // MARK: textFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

