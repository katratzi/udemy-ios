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

        // we found our image anchor
        if let planeAnchor = anchor as? ARImageAnchor {
            
            // load and play our video
            let videoNode = SKVideoNode(fileNamed: "harrypotter.mp4")
            videoNode.play()
            
            
            
            // video resolution for size
            let videoScene = SKScene(size: CGSize(width: 640, height: 360))
            
            videoNode.position = CGPoint(
                x: videoScene.size.width/2,
                y: videoScene.size.height/2)
            videoNode.yScale = -1 // flip the video so it's the right way up
            
            videoScene.addChild(videoNode)
            
            // create a plane in our view
            let plane = SCNPlane(
                width: planeAnchor.referenceImage.physicalSize.width,
                height: planeAnchor.referenceImage.physicalSize.height)
            
            // plane white material
//            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            // use video scene as material
            plane.firstMaterial?.diffuse.contents = videoScene
            
            // add node on top
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -Float.pi/2
            
            // add as child at this location
            node.addChildNode(planeNode)
        }
        
    }
}
