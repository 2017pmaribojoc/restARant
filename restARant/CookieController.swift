//
//  ViewController.swift
//  restARant
//
//  Created by Patrick Maribojoc on 4/15/18.
//  Copyright © 2018 PatrickMaribojoc. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class CookieController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView2: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView2.debugOptions = ARSCNDebugOptions.showWorldOrigin
        addCar()
//
//        // Set the view's delegate
//        sceneView2.delegate = self
//
//        // Show statistics such as fps and timing information
//        sceneView2.showsStatistics = true
//
//        // Create a new scene
//        //        let scene = SCNScene(named: "art.scnassets/ship.scn")!
//        let scene = SCNScene(named: "art.scnassets/cookie_dae/cookie_3.dae")!
//
//        // Set the scene to the view
//        sceneView2.scene = scene
    }
    
    func addCar(x: Float = 1, y: Float = 0, z: Float = -0.5) {
        guard let carScene = SCNScene(named: "art.scnassets/cookie_dae/cookie_3.dae") else { return }
        let carNode = SCNNode()
        let carSceneChildNodes = carScene.rootNode.childNodes
        
        for childNode in carSceneChildNodes {
            carNode.addChildNode(childNode)
        }
        
        carNode.position = SCNVector3(x, y, z)
        carNode.scale = SCNVector3(0.5, 0.5, 0.5)
        sceneView2.scene.rootNode.addChildNode(carNode)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView2.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView2.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

