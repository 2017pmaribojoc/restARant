//
//  MainMenuViewController.swift
//  restARant
//
//  Created by Patrick Maribojoc on 5/9/18.
//  Copyright © 2018 PatrickMaribojoc. All rights reserved.
//

import UIKit
import SideMenu
import SceneKit
import ARKit

class MainMenuViewController: UIViewController, ARSCNViewDelegate  {
    
    var globalAnchor: ARPlaneAnchor!
    var globalNode: SCNNode!
    
    @IBOutlet weak var scanTableLabel: UILabel!
    @IBOutlet var restaurantSceneView: ARSCNView!
    
    fileprivate var selectedIndex = 0
    fileprivate var transitionPoint: CGPoint!
    fileprivate var contentType: ContentType = .Music
    fileprivate var navigator: UINavigationController!
    
    lazy fileprivate var menuAnimator : MenuTransitionAnimator! = MenuTransitionAnimator(mode: .presentation, shouldPassEventsOutsideMenu: false) { [unowned self] in
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier, segue.destination) {
        case (.some("presentMenu"), let menu as SideMenuViewController):
            print("case: presentMenu");
            menu.selectedItem = selectedIndex
            menu.delegate = self
            menu.transitioningDelegate = self
            menu.modalPresentationStyle = .custom
        case (.some("embedNavigator"), let navigator as UINavigationController):
            self.navigator = navigator
            self.navigator.delegate = self
        default:
            super.prepare(for: segue, sender: sender)
        }
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
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        print("Rendering");
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        globalAnchor = planeAnchor
        globalNode = node
        DispatchQueue.main.async {
            self.scanTableLabel.isHidden = true
//            self.restaurantSceneView.isHidden = true
        }
        
    }
    
    func setUpSceneView() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        restaurantSceneView.session.run(configuration)
        
        restaurantSceneView.delegate = self
        restaurantSceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
         print("2");
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        //        // Create a session configuration
        //        let configuration = ARWorldTrackingConfiguration()
        //
        //        // Run the view's session
        //        restaurantSceneView.session.run(configuration)
        print("1");
        setUpSceneView()
    }
}

extension MainMenuViewController: SideMenuViewControllerDelegate {
    
    func menu(_: SideMenuViewController, didSelectItemAt index: Int, at point: CGPoint) {
        
        
        // Get ContentViewController if one exists
        // Load appropriate asset

        
//        contentType = !contentType
//        transitionPoint = point
//        selectedIndex = index
        print("INSIDE MENU FUNCTION");
        print(index);
        guard let node = globalNode else{
            return
        }
        for childNode in node.childNodes {
            childNode.removeFromParentNode()
        }
        print("adding asset...");
        if (index == 1){
            addAsset(assetname: "art.scnassets/salmon_empanadas/empanada.dae", scale: 0.25, node: node)
        } else if (index == 2){
            addAsset(assetname: "art.scnassets/gyoza/gyoza.dae", scale: 0.25, node: node)
        } else if (index == 3){
            addAsset(assetname: "art.scnassets/ricotta_tartine/ricotta_tartini2.dae", scale: 0.25, node: node)
        } else if (index == 4){
            addAsset(assetname: "art.scnassets/kebab/source/kebab2.dae", scale: 0.25, node: node)
        } else if (index == 5){
            addAsset(assetname: "art.scnassets/wagamama/wagamama.dae", scale: 0.25, node: node)
        } else if (index == 6){
            addAsset(assetname: "art.scnassets/spicy-korean-fried-chicken/source/korean-fried-chicken.dae", scale: 0.25, node: node)
        } else if (index == 7){
            addAsset(assetname: "art.scnassets/dutch-boy-idaho-fries-with-chili-cheese/source/chili-cheese-fries.dae", scale: 0.25, node: node)
        } else if (index == 8){
            addAsset(assetname: "art.scnassets/salmon/salmon.dae", scale: 0.1, node: node)
        } else if (index == 9){
            addAsset(assetname: "art.scnassets/sesame-bagel/sesame-bagel.dae", scale: 0.1, node: node)
        } else if (index == 10){
            addAsset(assetname: "art.scnassets/fruit-cake/fruit-cake.dae", scale: 0.1, node: node)
        }
        
//        let content = storyboard!.instantiateViewController(withIdentifier: "Content") as! ContentViewController
//        print(contentType.rawValue);
//        content.type = contentType
//        content.globalAnchor = globalAnchor
//        content.globalNode = globalNode
//
//
//        navigator.setViewControllers([content], animated: true)
//        restaurantSceneView.isHidden = true
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func menuDidCancel(_: SideMenuViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension MainMenuViewController: UINavigationControllerDelegate {
    
    func navigationController(_: UINavigationController, animationControllerFor _: UINavigationControllerOperation,
                              from _: UIViewController, to _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if let transitionPoint = transitionPoint {
            return CircularRevealTransitionAnimator(center: transitionPoint)
        }
        return nil
    }
}

extension MainMenuViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting _: UIViewController,
                             source _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return menuAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MenuTransitionAnimator(mode: .dismissal)
    }
}
