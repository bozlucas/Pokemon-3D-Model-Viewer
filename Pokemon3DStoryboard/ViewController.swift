//
//  ViewController.swift
//  Pokemon3DStoryboard
//
//  Created by Lucas on 2023-02-22.
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
        
        sceneView.autoenablesDefaultLighting = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main) {
            configuration.detectionImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 2
            
            
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
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor{
            
            
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.eulerAngles.x = -.pi/2
            
            node.addChildNode(planeNode)
            
            if imageAnchor.referenceImage.name == "gardevoir-card"{
                if let pokemonScene = SCNScene(named: "art.scnassets/gardevoir-scene-new.scn"){
                    if let pokemonNode = pokemonScene.rootNode.childNodes.first {
                        
                        pokemonNode.eulerAngles.x = .pi
                        planeNode.addChildNode(pokemonNode)
                    }
                }
            }
            
            if imageAnchor.referenceImage.name == "chewtle-card"{
                if let pokemonScene = SCNScene(named: "art.scnassets/chewtle-scene.scn"){
                    if let pokemonNode = pokemonScene.rootNode.childNodes.first {
                        
                        pokemonNode.eulerAngles.x = .pi
                        planeNode.addChildNode(pokemonNode)
                    }
                }
            }
            
            
            
            
        }
        
        return node
    }

}
