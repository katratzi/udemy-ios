//
//  ViewController.swift
//  ar magic newspaper
//
//  Created by Richard Clifford on 02/04/2023.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imagesToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Magic News Images", bundle: Bundle.main) {
            
            configuration.trackingImages = imagesToTrack
            configuration.maximumNumberOfTrackedImages = 1
            
            print("Images successfully added")
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    //MARK: - ARSCViewDelegates
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {

        if let planeAnchor = anchor as? ARImageAnchor {
            print("found image")
            let plane = SCNPlane(
                width: planeAnchor.referenceImage.physicalSize.width,
                height: planeAnchor.referenceImage.physicalSize.width)
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            
            // add node on top
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -Float.pi/2
            
            // add as child at this location
            node.addChildNode(planeNode)
        }
        
    }
}
