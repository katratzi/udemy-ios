//
//  ViewController.swift
//  poke 3d
//
//  Created by Richard Clifford on 31/03/2023.
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
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // let there be light
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imagesToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main) {
            
            configuration.trackingImages = imagesToTrack
            
            configuration.maximumNumberOfTrackedImages = 2
            
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
    
    // MARK: - ARSCNViewDelegate
    
    // when an anchor gets detected this method gets called
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        // did we detect an image anchor
        if let imageAnchor = anchor as? ARImageAnchor {
            
            
            
            let plane = SCNPlane(
                width: imageAnchor.referenceImage.physicalSize.width,
                height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -Float.pi/2
            
            node.addChildNode(planeNode)
            
            // which model should be loaded
            let model = imageAnchor.name == "eevee-card" ? "eevee" : "oddish"
            
            // add our 3d model and orientate
            let pokeScene = SCNScene(named: "art.scnassets/\(model).scn")!
            let pokeNode = pokeScene.rootNode.childNode(withName: model, recursively: true)!
            pokeNode.eulerAngles.x = Float.pi/2
            
            planeNode.addChildNode(pokeNode)
        }
        
        
        
        return node
    }

    
}
