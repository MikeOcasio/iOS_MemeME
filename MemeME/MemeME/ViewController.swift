//
//  ViewController.swift
//  MemeME
//
//  Created by Mike Ocasio on 1/22/18.
//  Copyright © 2018 Mike Ocasio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerButton: UIBarButtonItem!
    
   
    override func viewWillAppear(_ animated: Bool) {
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
      
        setupLayout()
        
    }
    

    private func setupLayout() {
        
            // MARK: TextField Default Attributes
        
        let memeTextAttributes:[String:Any] = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black  ,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white ,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedStringKey.strokeWidth.rawValue: 4.0 ]
        
        let top = "TOP"
        let bottom = "BOTTOM"
        
        // Top TxtField Default Attributes
        
        topTextField.borderStyle = .none
       // topTextField.backgroundColor = .clear
        topTextField.placeholder = top
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .center
        topTextField.textColor = .white
        
        //This Enables AutoLayout into our view controller.
        topTextField.translatesAutoresizingMaskIntoConstraints = false
        
           // MARK: Top Text Field Layout Contraints
        
        topTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topTextField.topAnchor.constraint(equalTo: imagePickerView.topAnchor, constant: 25).isActive = true
        topTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        topTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Bottom TxtField Default Attributes
        
        bottomTextField.borderStyle = .none
        bottomTextField.backgroundColor = .clear
        bottomTextField.placeholder = bottom
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = .center
        bottomTextField.textColor = .white
        
        //This Enables AutoLayout into our view controller.
        bottomTextField.translatesAutoresizingMaskIntoConstraints = false
        
            // MARK: Bottom Text Field Layout Contraints
        
        bottomTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomTextField.bottomAnchor.constraint(equalTo: imagePickerView.bottomAnchor, constant: -25).isActive = true
        bottomTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        bottomTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //This enables AutoLayout into our view controller.
        imagePickerView.translatesAutoresizingMaskIntoConstraints = false
        
            // MARK: UIImage Viewer Layout Constraints
        
        imagePickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imagePickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imagePickerView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        imagePickerView.heightAnchor.constraint(equalToConstant: 375).isActive = true
        imagePickerView.contentMode = .scaleAspectFill

    }

    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
    
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any)
    
    {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        view.frame.origin.y = 0 - getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    @objc func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }


    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
        imagePickerView.image = image
            
        }
            
        else {
            
            // Error Message here
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }

}
