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
    var shopIcon: SKSpriteNode?
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor()
        var bg = SKSpriteNode(imageNamed: "background.png")
        bg.zPosition = 0
        
        addShopIcon()
        self.addChild(bg)
        //bg.position(CGPoint(x: self.size.width/2, y: self.size.height/2))
        bg.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        
        
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {

        var touch = touches.anyObject() as UITouch
        var currentTouchPoint = touch.locationInNode(self)

        if currentTouchPoint.x > shopIcon!.frame.minX && currentTouchPoint.y > shopIcon!.frame.minY { // subtract by sprite (button size) later
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
    
    func addShopIcon(){
        shopIcon = SKSpriteNode(color: UIColor.greenColor(), size: CGSize(width: size.width*0.2, height: size.height*0.2))
        shopIcon!.position.x = size.width - shopIcon!.size.width/2
        shopIcon!.position.y = size.height - shopIcon!.size.height/2
        shopIcon!.zPosition = 0.1
        addChild(shopIcon!)
        
        
        
    }

}
