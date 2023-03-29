//
//  ViewController.swift
//  ARDicee
//
//  Created by Richard Clifford on 30/03/2023.
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
        
        
        
        //        // lets add a simple cube to our scene with a red material
        //        let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
        //        let material = SCNMaterial()
        //        material.diffuse.contents = UIColor.red
        //        cube.materials = [material]
        //
        //        // add a sphere
        //        let sphere = SCNSphere(radius: 0.2)
        //        material.diffuse.contents = UIImage(named: "art.scnassets/2k_moon.jpg")
        //        sphere.materials = [material]
        
        //        let node = SCNNode()
        //        node.position = SCNVector3(x: 0, y: 0.1, z: -0.5)
        //        node.geometry = sphere
        
        // add to our scene
        //        sceneView.scene.rootNode.addChildNode(node)
        
        
        // Create a new scene for dice
        let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
        
        if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true) {
            diceNode.position = SCNVector3(x: 0, y: 0, z: -0.1)
            diceNode.scale = SCNVector3(10, 10, 10)
            sceneView.scene.rootNode.addChildNode(diceNode)
        } else {
            print("dice not found")
        }
        
        // Set the scene to the view
        // sceneView.scene = diceScene
        
        
        sceneView.autoenablesDefaultLighting = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
}
