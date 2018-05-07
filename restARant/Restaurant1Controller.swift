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

class Restaurant1Controller: UIViewController, ARSCNViewDelegate {
    
    var globalAnchor: ARPlaneAnchor!
    var globalNode: SCNNode!

    @IBOutlet weak var scanTableLabel: UILabel!
    @IBOutlet var restaurantSceneView: ARSCNView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // 1
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }

        globalAnchor = planeAnchor
        // 6
        globalNode = node
        DispatchQueue.main.async {
            self.scanTableLabel.isHidden = true
        }
        
    }
    
    func setUpSceneView() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
    
        restaurantSceneView.session.run(configuration)
        
        restaurantSceneView.delegate = self
        restaurantSceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }
    
    func configureLighting() {
        restaurantSceneView.autoenablesDefaultLighting = true
        restaurantSceneView.automaticallyUpdatesLighting = true
    }
    
    @IBAction func addBread(_ sender: UIButton) {
        guard let node = globalNode else{
            return
        }
        for childNode in node.childNodes {
            childNode.removeFromParentNode()
        }
        
        guard let breadScene = SCNScene(named: "art.scnassets/bread/bread.dae") else { return }
        let breadNode = SCNNode()
        let breadSceneChildNodes = breadScene.rootNode.childNodes
        
        for childNode in breadSceneChildNodes {
            breadNode.addChildNode(childNode)
        }
        
        let x = CGFloat(globalAnchor.center.x)
        let y = CGFloat(globalAnchor.center.y)
        let z = CGFloat(globalAnchor.center.z)
        breadNode.position = SCNVector3(x,y,z)
        breadNode.scale = SCNVector3(0.25, 0.25, 0.25)
        node.addChildNode(breadNode)

    }
    
    @IBAction func addPizza(_ sender: UIButton) {
        guard let node = globalNode else{
            return
        }
        for childNode in node.childNodes {
            childNode.removeFromParentNode()
        }
        
        guard let carScene = SCNScene(named: "art.scnassets/chocolate-chip-muffin/source/muffin.dae") else { return }
        let carNode = SCNNode()
        let carSceneChildNodes = carScene.rootNode.childNodes
        
        for childNode in carSceneChildNodes {
            carNode.addChildNode(childNode)
        }
        
        let x = CGFloat(globalAnchor.center.x)
        let y = CGFloat(globalAnchor.center.y)
        let z = CGFloat(globalAnchor.center.z)
        carNode.scale = SCNVector3(6.0, 6.0, 6.0)
        carNode.position = SCNVector3(x,y,z)
        node.addChildNode(carNode)
        
    }
    
    @IBAction func addKoreanChicken(_ sender: UIButton) {
        guard let node = globalNode else{
            return
        }
        for childNode in node.childNodes {
            childNode.removeFromParentNode()
        }
        
        guard let breadScene = SCNScene(named: "art.scnassets/spicy-korean-fried-chicken/source/korean-fried-chicken.dae") else { return }
        let breadNode = SCNNode()
        let breadSceneChildNodes = breadScene.rootNode.childNodes
        
        for childNode in breadSceneChildNodes {
            breadNode.addChildNode(childNode)
        }
        
        let x = CGFloat(globalAnchor.center.x)
        let y = CGFloat(globalAnchor.center.y)
        let z = CGFloat(globalAnchor.center.z)
        breadNode.position = SCNVector3(x,y,z)
        breadNode.scale = SCNVector3(0.25, 0.25, 0.25)
        node.addChildNode(breadNode)
        
    }
    
    @IBAction func addFries(_ sender: UIButton) {
        guard let node = globalNode else{
            return
        }
        for childNode in node.childNodes {
            childNode.removeFromParentNode()
        }
        
        guard let breadScene = SCNScene(named: "art.scnassets/dutch-boy-idaho-fries-with-chili-cheese/source/chili-cheese-fries.dae") else { return }
        let breadNode = SCNNode()
        let breadSceneChildNodes = breadScene.rootNode.childNodes
        
        for childNode in breadSceneChildNodes {
            breadNode.addChildNode(childNode)
        }
        
        let x = CGFloat(globalAnchor.center.x)
        let y = CGFloat(globalAnchor.center.y)
        let z = CGFloat(globalAnchor.center.z)
        breadNode.position = SCNVector3(x,y,z)
        breadNode.scale = SCNVector3(0.25, 0.25, 0.25)
        node.addChildNode(breadNode)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//
//        // Create a session configuration
//        let configuration = ARWorldTrackingConfiguration()
//
//        // Run the view's session
//        restaurantSceneView.session.run(configuration)
        setUpSceneView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        restaurantSceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
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

