//
//  ShopScene.swift
//  sk-gl-mate
//
//  Created by Arūnas Seniucas on 3/25/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class ShopScene: SKScene{
    
    var controller: GameViewController?
    var backButton: SKLabelNode?
    
    override func didMoveToView(view: SKView) {

        backgroundColor = SKColor.greenColor()
        addBackButton()
        
        
        
    }
    
    func addBackButton(){
        backButton = SKLabelNode(fontNamed: "Helvetica")
        
        backButton!.text = "Try again!"
        backButton!.fontColor = SKColor.whiteColor()
        backButton!.fontSize = 30
        backButton!.position = CGPoint(x: 10, y: size.height - backButton!.frame.height)
        backButton!.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        
        addChild(backButton!)
}
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        
        var touch = touches.anyObject() as UITouch
        var currentTouchPoint = touch.locationInNode(self)
        
        
        if currentTouchPoint.x < backButton!.frame.maxX && currentTouchPoint.y > backButton!.frame.minY {
            controller!.displayGameScene()
        }
        
    }
    
    init(size: CGSize, controller: GameViewController) {
        super.init(size: size)
        self.controller = controller
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}
