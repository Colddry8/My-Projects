//
//  LoginButton.swift
//  OnTheMap
//
//  Created by Денис Глущенко on 17/5/2566 BE.
//
import UIKit

// MARK: Login Button
class LoginButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 5
        tintColor = UIColor.white
        backgroundColor = UIColor.orange
    }
    
}
