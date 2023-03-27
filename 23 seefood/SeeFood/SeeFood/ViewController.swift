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
        
        // allows access to the camera to take image for picker
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
    }
    
    // this delegate method is called once the user has finished picking an image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // check an image was picked, cast to UIImage then set to background image
        if let userPickedImage = info[.originalImage] as? UIImage
        {
            imageView.image = userPickedImage
            
            // convert into image format for vision framework
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("Error converting image to CIImage")
            }
            
            detect(image: ciimage)
        }
        
        // dismiss image picker to go back to main view
        imagePicker.dismiss(animated: true)
        
    }
    
    func detect(image: CIImage){
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Load coreML Error")
        }
        
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation]  else {
                fatalError("Model failed to process iamge")
            }
            print(results)
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do
        {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
        @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true)
    }
    
    
}

