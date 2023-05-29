//
//  File.swift
//  OnTheMap
//
//  Created by Денис Глущенко on 17/5/2566 BE.
//
import UIKit

// MARK:  GradientView
class GradientView: UIView {
    
    var gradientLayer: CAGradientLayer!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        gradientLayer = CAGradientLayer()
        let colorTop = UIColor.orange.cgColor
        let colorBottom = UIColor.yellow.cgColor
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = frame
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        gradientLayer.frame = frame
    }
    
}



