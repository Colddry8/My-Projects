//
//  ContactViewController.swift
//  DeliveryApp
//
//  Created by Денис Глущенко on 14/1/2567 BE.
//


import UIKit



class ContactViewController: UIViewController {
    
    var presenter: ContactPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
    
    
}

extension ContactViewController: ContactViewProtocol {
    
}
