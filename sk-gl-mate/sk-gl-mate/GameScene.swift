//
//  GameScene.swift
//  sk-gl-mate
//
//  Created by Arūnas Seniucas on 3/7/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class GameScene: SKScene{
    
    var player: Player?
    var cDelegate:CustomContactDelegate?
    var touchPoint:CGPoint?
    var controller:GameViewController?
    
    var playerFooting:NSInteger = 0;
    
    struct PhysicsCategory {
        static let None      : UInt32 = 0
        static let All       : UInt32 = UInt32.max
        static let Player    : UInt32 = 0b1        // 1
        static let Monster   : UInt32 = 0b10       // 2
        static let Floor     : UInt32 = 0b100      // 4
    }
    
    init(size: CGSize, controller: GameViewController) {
        super.init(size: size)
        self.controller = controller
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        physicsWorld.gravity = CGVector(dx: 0, dy: -3)
        addPlayer()
        addGround()
        cDelegate = CustomContactDelegate(PrimaryPlayer: player!)
        physicsWorld.contactDelegate = cDelegate!
        
        
        
        
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(addMonster /*{ self.addMonster(self.goodInteger) } */),
                SKAction.waitForDuration(NSTimeInterval(random(min: 0.8, max: 1.5)))
                ])
            ))
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if player!.playerFooting > 0 {
            player!.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 2.5))
        }
        var touch = touches.anyObject() as UITouch
        touchPoint = touch.locationInNode(self)
        
        //player.runAction(jumpAction)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        var currentTouchPoint = touch.locationInNode(self)
        
        var difference = touchPoint!.y - currentTouchPoint.y //CGPoint(x: touchPoint!.x - currentTouchPoint.x, y: touchPoint!.y - currentTouchPoint.x)
        
        if(currentTouchPoint.x < player!.frame.minX && touchPoint!.x < player!.frame.minX){
            player!.physicsBody?.applyAngularImpulse(difference * -0.0001)
        }
        else{
            player!.physicsBody?.applyAngularImpulse(difference * 0.0001)
        }
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if(player!.frame.midX < 0 || player!.frame.midX > size.width){
            println("Game over, m8")
            controller?.displayEndScene()
            
        }
    }
    
    func addPlayer(){
        player = Player(imageNamed: "player.png")
        player!.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        //player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)
        //player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size, center: CGPoint(x: player.size.width*0.15, y: player.size.height*0.15))
        player!.physicsBody = SKPhysicsBody(rectangleOfSize: player!.size)
        player!.physicsBody?.categoryBitMask = PhysicsCategory.Player
        player!.physicsBody?.collisionBitMask = PhysicsCategory.Floor | PhysicsCategory.Monster
        player!.physicsBody?.contactTestBitMask = PhysicsCategory.Floor | PhysicsCategory.Monster
        player!.physicsBody?.restitution = 0
        player!.physicsBody?.dynamic = true
        addChild(player!)
        
    }
    
    func addGround(){
        //var floor = SKShapeNode(CGRect(x: 0, y: 0, width: size.width, height: size.height * 0.01))
        var floor = SKSpriteNode(color: SKColor.blackColor(), size: CGSize(width: size.width, height: size.height * 0.01)) //(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height * 0.01))
        floor.position = CGPoint(x: size.width/2, y: 0)
        floor.physicsBody = SKPhysicsBody(rectangleOfSize: floor.frame.size)
        //floor.physicsBody = SKPhysicsBody(rectangleOfSize: floor.frame.size, center: CGPoint(x: floor.frame.size.width/2, y: floor.frame.size.height/2))
        //floor.physicsBody = SKPhysicsBody(edgeLoopFromRect: floor.frame)
        floor.physicsBody?.categoryBitMask = PhysicsCategory.Floor
        floor.physicsBody?.contactTestBitMask = PhysicsCategory.All
        floor.physicsBody?.collisionBitMask = PhysicsCategory.All
        floor.physicsBody?.restitution = 0
        floor.physicsBody?.dynamic = false
        
        addChild(floor)
    }
    
    func addMonster(){
        var monster = SKSpriteNode(imageNamed: "monster.png")
        monster.position = CGPoint(x: size.width * 0.995, y: size.height * 0.1)
        //monster.physicsBody = SKPhysicsBody(rectangleOfSize: monster.size, center: CGPoint(x: monster.size.width*0.15, y: monster.size.height*0.15))
        monster.physicsBody = SKPhysicsBody(rectangleOfSize: monster.size)
        monster.physicsBody?.categoryBitMask = PhysicsCategory.Monster
        monster.physicsBody?.collisionBitMask = PhysicsCategory.Floor | PhysicsCategory.Player | PhysicsCategory.Monster
        monster.physicsBody?.contactTestBitMask = PhysicsCategory.Floor | PhysicsCategory.Player | PhysicsCategory.Monster
        monster.physicsBody?.dynamic = true
        
        addChild(monster)
        
        let actualDuration = random(min: CGFloat(2.5), max: CGFloat(3.2))
        
        //let moveAction = SKAction.moveTo(CGPoint(x: 0, y: monster.position.y), duration: NSTimeInterval(actualDuration))
        let moveAction = SKAction.moveBy(CGVector(dx: -size.width * 0.01, dy: 0.01), duration: 0.022)
        let dieAction = SKAction.removeFromParent()
        
        
        //monster.runAction(SKAction.sequence([moveAction, dieAction]))
        monster.runAction( SKAction.sequence([ SKAction.repeatAction(moveAction, count: 300), dieAction ]))
        //monster.runAction(SKAction.repeatActionForever(SKAction.sequence([moveAction, SKAction.waitForDuration(0.005)])))
    }
    
    
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
}
