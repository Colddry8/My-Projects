//
//  MemeDetailViewController.swift
//  Meme
//
//  Created by Денис Глущенко on 14/4/2566 BE.
//

import UIKit

// MARK: MemeDetailViewController
class MemeDetailViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var ImageView: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ImageView.image = meme.memedImage
    }
}
