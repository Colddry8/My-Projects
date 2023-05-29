//
//  Extensions.swift
//  OnTheMap
//
//  Created by Денис Глущенко on 18/5/2566 BE.
//

import UIKit
// MARK: Extensions
extension UIViewController {
    
    // MARK: showFailure
    func showFailure(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
