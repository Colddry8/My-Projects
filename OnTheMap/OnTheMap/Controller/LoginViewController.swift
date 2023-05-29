//
//  ViewController.swift
//  OnTheMap
//
//  Created by Денис Глущенко on 16/5/2566 BE.
//

import UIKit

// MARK: LoginViewController
class LoginViewController: UIViewController, UITextFieldDelegate {

    // MARK: LoginViewControllerOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
   
    @IBOutlet weak var loginButton: LoginButton!
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }

    // MARK: IBActionLogin
    
    @IBAction func login(_ sender: UIButton) {
        UdacityClient.login(userName: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: self.handleLoginResponse(success:error:))
    }
    
    
    // MARK: HandleLoginResponse
    func handleLoginResponse(success: Bool, error: Error?)
    {
        if success
        {
            UdacityClient.getStudentUserData(completion: handleGetStudentUserData(success:error:))
            UdacityClient.getStudentInformation(completion: handleGetStudentInformation(data:error:))
            
        } else
        {
            showFailure(title: "Login error", message: error?.localizedDescription ?? "")
        }
    }
    
    // MARK: HandleGetStudentUserData
    func handleGetStudentUserData(success: Bool, error: Error?)
    {
        if !success
        {
            showFailure(title: "User Data error", message: error?.localizedDescription ?? "")
        }
    }
    
    // MARK: HandleGetStudentInformation
    func handleGetStudentInformation(data: [StudentLocation], error: Error?)
    {
        if error == nil
        {
            StudentModel.data = data
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
        } else
        {
            showFailure(title: "Location Data error", message: error?.localizedDescription ?? "")
        }
    }
    
    
    // MARK: textFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

