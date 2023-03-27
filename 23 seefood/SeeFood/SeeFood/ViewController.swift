//
//  ViewController.swift
//  SeeFood
//
//  Created by Richard Clifford on 28/03/2023.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
    }

   
}

