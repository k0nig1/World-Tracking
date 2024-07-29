//
//  ViewController.swift
//  World Tracking
//
//  Created by Daniel Holterhaus on 8/21/19.
//  Copyright © 2019 Daniel Holterhaus. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view.
    }

    @IBAction func add(_ sender: Any) {
        let rootNode = self.sceneView.scene.rootNode
        let pyramid = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1))
        
        pyramid.geometry?.firstMaterial?.diffuse.contents = UIColor.orange
        pyramid.position = SCNVector3(0, 0, -0.3)
        pyramid.eulerAngles = SCNVector3(Float(90.degreesToRadians), 0, 0)
        rootNode.addChildNode(pyramid)
        
//        node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
//        node.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
//        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
//        node.geometry?.firstMaterial?.specular.contents = UIColor.white
//        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
//        let x = self.randomNumbers(firstNum: -0.3, secondNum: 0.3)
//        let y = self.randomNumbers(firstNum: -0.3, secondNum: 0.3)
//        let z = self.randomNumbers(firstNum: -0.3, secondNum: 0.3)
//        node.position = SCNVector3(x, y, z)
//        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    @IBAction func reset(_ sender: Any) {
        self.restartSession()
    }
    
    func restartSession(){
        self.sceneView.session.pause()
        let rootNode = self.sceneView.scene.rootNode
        rootNode.enumerateChildNodes{ (node, _) in
            node.removeFromParentNode()
        }
        
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}

extension Int {
    var degreesToRadians: Double {
        return Double(self) * .pi/180
    }
}
