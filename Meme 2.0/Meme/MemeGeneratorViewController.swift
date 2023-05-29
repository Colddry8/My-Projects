//
//  ViewController.swift
//  Meme
//
//  Created by Денис Глущенко on 8/3/2566 BE.
//

import UIKit

class MemeGeneratorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate
{
    // MARK: IBOutlets
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var meme: Meme!
    // MARK: memeTextAttributes
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -7.0,
    ]
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.isEnabled = false
        setupTextField(textField: topTextField, text: "TOP")
        setupTextField(textField: bottomTextField, text: "BOTTOM")
    }

    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
#if targetEnvironment(simulator)
       cameraButton.isEnabled = false
       #else
       cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
       #endif
    }
    
    // MARK: setupTextField
    func setupTextField(textField: UITextField, text: String) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.text = "\(text)"
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.clear
        textField.delegate = self
        }
    
    // MARK: subscribeToKeyboardNotifications
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // MARK: unsubscribeFromKeyboardNotifications
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: keyboardWillShow
    @objc func keyboardWillShow(_ notification:Notification) {
        
        view.frame.origin.y = -getKeyboardHeight(notification)
    }
    
    // MARK: keyboardWillHide
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
   
    // MARK: getKeyboardHeight
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        
        return keyboardSize.cgRectValue.height
    }
    
    // MARK: shareMemeImage
    @IBAction func shareMemeImage(_ sender: Any) {
        let meme = [generateMemedImage()]
        let complete = UIActivityViewController(activityItems: meme, applicationActivities: nil)
        present(complete, animated: true, completion: nil)
        complete.completionWithItemsHandler = {_, bool, _, _ in
            if bool {
                self.save()
            }
        }
    }
    
    // MARK: pickImage
    func pickImage(source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = source
            present(imagePicker, animated: true, completion: nil)
        }
    
    // MARK: pickAnImageFromAlbum
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        pickImage(source: .photoLibrary)
    }
    
    // MARK: pickAnImageFromCamera
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pickImage(source: .camera)
    }
    
    // MARK: imagePickerController
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    shareButton.isEnabled = true
    if let image = info[.originalImage] as? UIImage {
        imagePickerView.image = image
    }
    dismiss(animated: true, completion: nil)
  }
    
    // MARK: textFieldDidBeginEditing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" ||  textField.text == "BOTTOM"{
            textField.text = ""
        }
       if textField == bottomTextField {
            subscribeToKeyboardNotifications()
        }
    }
    
    // MARK: textFieldDidEndEditing
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == bottomTextField {
            unsubscribeFromKeyboardNotifications()
        }
    }
    
    // MARK: textFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: save
    func save() {
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
        
    }
    
    // MARK: generateMemedImage
    func generateMemedImage() -> UIImage {
        // Hide ToolBar and NavigationBar
        toolBar.isHidden = true
        navigationBar.titleView?.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show ToolBar and NavigationBar
        toolBar.isHidden = false
        navigationBar.titleView?.isHidden = false
        
        return memedImage
    }
    
    // MARK: CancelButton
    @IBAction func CancelButton(_ sender: Any) {
        dismiss(animated: true)
    }
}

