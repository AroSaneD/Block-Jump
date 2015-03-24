//
//  EndScene.swift
//  sk-gl-mate
//
//  Created by Arūnas Seniucas on 3/18/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class EndScene : SKScene{
    
    var controller: GameViewController?
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor()
        var bg = SKSpriteNode(imageNamed: "background.png")
        
        self.addChild(bg)
        //bg.position(CGPoint(x: self.size.width/2, y: self.size.height/2))
        bg.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {

        var touch = touches.anyObject() as UITouch
        var currentTouchPoint = touch.locationInNode(self)

        if currentTouchPoint.x > size.width*0.3 && currentTouchPoint.y > size.width*0.3{ // subtract by sprite (button size) later
            controller?.displayShopScreen()
        }
        else{
            controller?.displayGameScene()
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
