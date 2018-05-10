//
//  ContentViewController.swift
//  restARant
//
//  Created by Patrick Maribojoc on 5/9/18.
//  Copyright © 2018 PatrickMaribojoc. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ContentViewController: UIViewController, ARSCNViewDelegate {
    
    var type: ContentType = .Music
    var globalAnchor: ARPlaneAnchor!
    var globalNode: SCNNode!
    
    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var scanTableLabel: UILabel!
    @IBOutlet var restaurantSceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ContentViewController viewDidLoad");
        print(type.rawValue);
//        imageView.image = UIImage(named: type.rawValue)
        guard let node = globalNode else{
            return
        }
        for childNode in node.childNodes {
            childNode.removeFromParentNode()
        }
        print("adding asset...");
        addAsset(assetname: "art.scnassets/salmon_empanadas/empanada.dae", scale: 0.25, node: node)
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
    
//    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//        print("Rendering");
//        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
//
//        globalAnchor = planeAnchor
//        globalNode = node
//        DispatchQueue.main.async {
//            self.scanTableLabel.isHidden = true
//        }
//
//    }
    
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
    
    func addAsset(assetname: String, scale: Double, node: SCNNode){
        print("addAsset");
        guard let newScene = SCNScene(named: assetname) else { return }
        let newNode = SCNNode()
        let newSceneChildNodes = newScene.rootNode.childNodes
        
        for childNode in newSceneChildNodes {
            newNode.addChildNode(childNode)
        }
        
        let x = CGFloat(globalAnchor.center.x)
        let y = CGFloat(globalAnchor.center.y)
        let z = CGFloat(globalAnchor.center.z)
        newNode.position = SCNVector3(x,y,z)
        newNode.scale = SCNVector3(scale,scale,scale)
        node.addChildNode(newNode)
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
