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
    var honorPoints: SKLabelNode?
    var shopKeeper: SKSpriteNode?
    
    var doubleJumpButton: SKSpriteNode?
    
    override func didMoveToView(view: SKView) {

        backgroundColor = SKColor.blueColor()
        addBackButton()
        addHonorLabel()
        addDoubleJumpButton()
        addShopKeeper()
        addMessage("How can I be of helpings? ^^")
        addUnknown(CGPoint(x: size.width / 4, y: size.height / 2))
        addUnknown(CGPoint(x: size.width / 2, y: size.height / 2))
        addUnknown(CGPoint(x: size.width * 0.75, y: size.height / 2))
        addUnknown(CGPoint(x: size.width * 0.875, y: size.height / 2))
        
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
    
    func addShopKeeper(){
        shopKeeper = SKSpriteNode(imageNamed: "shopKeeper.png")
        shopKeeper!.position = CGPoint(x: size.width - shopKeeper!.frame.width * 0.25, y: shopKeeper!.frame.height * 0.25)
        shopKeeper!.zRotation = CGFloat(M_PI * 0.25)
        
        addChild(shopKeeper!)
    }
    
    func addMessage(msg: NSString){
        // add a way to dynamically set the position to fit the messsage into the screen
        
        var message = SKLabelNode(fontNamed: "Arial")
        message.text = msg
        message.fontColor = SKColor.whiteColor()
        message.fontSize = 20
        message.position = CGPoint(x: shopKeeper!.frame.minX - shopKeeper!.frame.width * 0.40, y: 5)
        message.zRotation = CGFloat(M_PI * 0.25)
        message.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        addChild(message)
    }
    
    func addHonorLabel(){
        honorPoints = SKLabelNode(fontNamed: "Helvetica")
        
        honorPoints!.text = "\(controller!.honorPoints)"
        honorPoints!.fontColor = SKColor.whiteColor()
        honorPoints!.fontSize = 30
        honorPoints!.position = CGPoint(x: size.width - 10, y: size.height - backButton!.frame.height)
        honorPoints!.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        
        addChild(honorPoints!)
    }
    
    func addUnknown(point: CGPoint){
        var unknown = SKSpriteNode(imageNamed: "unknown.png")
        unknown.position = point
        unknown.zPosition = 1
        addChild(unknown)
    }
    
    func addDoubleJumpButton(){
        doubleJumpButton = SKSpriteNode(imageNamed: "double.png")
        doubleJumpButton!.position = CGPoint(x: size.width / 8, y: size.height / 2)
        doubleJumpButton!.zPosition = 1
        addChild(doubleJumpButton!)
        if controller!.doubleJump {
            addPurchasedText(doubleJumpButton!.frame)
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        
        var touch = touches.anyObject() as UITouch
        var currentTouchPoint = touch.locationInNode(self)
        
        
        if currentTouchPoint.x < backButton!.frame.maxX && currentTouchPoint.y > backButton!.frame.minY {
            controller!.displayGameScene()
        }
        
        if currentTouchPoint.x > doubleJumpButton!.frame.minX && currentTouchPoint.x < doubleJumpButton!.frame.maxX && currentTouchPoint.y < doubleJumpButton!.frame.maxY && currentTouchPoint.y > doubleJumpButton!.frame.minY && !controller!.doubleJump{
            
            if controller!.honorPoints >= 100 {
                controller!.doubleJump = true
                controller!.honorPoints -= 100
                
                addPurchasedText(doubleJumpButton!.frame)
                
                honorPoints!.text = "\(controller!.honorPoints)"
                
            }
        }
        
    }
    
    func addPurchasedText(buttonFrame: CGRect) {
        var purchased = SKLabelNode(fontNamed: "Arial")
        purchased.fontColor = SKColor.whiteColor()
        purchased.fontSize = 15
        purchased.text = "Purchased"
        purchased.position = CGPoint(x: buttonFrame.midX, y: buttonFrame.midY)
        purchased.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        purchased.zRotation = CGFloat(M_PI - M_PI * 1.25)
        purchased.zPosition = 2
        addChild(purchased)
    }
    
    init(size: CGSize, controller: GameViewController) {
        super.init(size: size)
        self.controller = controller
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}
