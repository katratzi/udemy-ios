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
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
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
        
        
//        // Create a new scene for dice
//        let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
//
//        if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true) {
//            diceNode.position = SCNVector3(x: 0, y: 0, z: -0.1)
//            diceNode.scale = SCNVector3(1, 1, 1)
//            sceneView.scene.rootNode.addChildNode(diceNode)
//        } else {
//            print("dice not found")
//        }
        
        // Set the scene to the view
        // sceneView.scene = diceScene
        
        
        sceneView.autoenablesDefaultLighting = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // check we actually had touches
        if let touch = touches.first
        {
            let touchLocation = touch.location(in: sceneView)
            
            let results = sceneView.hitTest(touchLocation, types: ARHitTestResult.ResultType.existingPlaneUsingExtent)
            
            // we hit something
            if let hitResult = results.first {
                // Create a new scene for dice
                let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
                
                // place in world...and get the world position from the 4x4 matrix
                if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true) {
                    diceNode.position = SCNVector3(
                        x: hitResult.worldTransform.columns.3.x,
                        y: hitResult.worldTransform.columns.3.y + diceNode.boundingSphere.radius,
                        z: hitResult.worldTransform.columns.3.z)
                    sceneView.scene.rootNode.addChildNode(diceNode)
                    
                    // random side to roll
                    arc4random_stir()
                    let randomX = Float(arc4random_uniform(4) + 1) * (Float.pi/2)
                    let randomZ = Float(arc4random_uniform(4) + 1) * (Float.pi/2)
                    
                    diceNode.runAction(SCNAction.rotateBy(
                        x: CGFloat(randomX),
                        y: 0,
                        z: CGFloat(randomZ),
                        duration: 0.5))
                }
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor
        {
            // print("plane detected")
            let planeAnchor = anchor as! ARPlaneAnchor
            
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
            
            let planeNode = SCNNode()
            planeNode.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
            // rotate vertical plane to horizontal along x axis
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
            
            let gridMaterial = SCNMaterial()
            gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
            plane.materials = [gridMaterial]
            planeNode.geometry = plane
            
            node.addChildNode(planeNode)
            
            
        } else
        {
            return
        }
    }
    
    
}
