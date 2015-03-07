//
//  GameScene.swift
//  sk-gl-mate
//
//  Created by Arūnas Seniucas on 3/7/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var player = SKSpriteNode(imageNamed: "player.png")
    var playerFooting:NSInteger = 0;
    
    struct PhysicsCategory {
        static let None      : UInt32 = 0
        static let All       : UInt32 = UInt32.max
        static let Player    : UInt32 = 0b1        // 1
        static let Monster   : UInt32 = 0b10       // 2
        static let Floor     : UInt32 = 0b100      // 4
    }
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        physicsWorld.gravity = CGVector(dx: 0, dy: -3)
        physicsWorld.contactDelegate = CustomContactDelegate()
        addPlayer(player)
        addGround()
        
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(addMonster /*{ self.addMonster(self.goodInteger) } */),
                SKAction.waitForDuration(NSTimeInterval(random(min: 0.8, max: 1.5)))
                ])
            ))
        
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var jumpAction = SKAction.moveBy(CGVector(dx: 0, dy: size.height*0.2), duration: 0.2)
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 2))
        //player.runAction(jumpAction)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func addPlayer(player: SKSpriteNode){
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        //player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size, center: CGPoint(x: player.size.width*0.15, y: player.size.height*0.15))
        player.physicsBody?.categoryBitMask = PhysicsCategory.Player
        player.physicsBody?.collisionBitMask = PhysicsCategory.Floor | PhysicsCategory.Monster
        player.physicsBody?.contactTestBitMask = PhysicsCategory.Monster
        player.physicsBody?.restitution = 0.3
        player.physicsBody?.dynamic = true
        addChild(player)
        
    }
    
    func addGround(){
        //var floor = SKShapeNode(CGRect(x: 0, y: 0, width: size.width, height: size.height * 0.01))
        var floor = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height * 0.01))
        floor.strokeColor = SKColor.blackColor()
        floor.position = CGPoint(x: 0, y: 0)
        floor.physicsBody = SKPhysicsBody(rectangleOfSize: floor.frame.size)
        floor.physicsBody = SKPhysicsBody(edgeLoopFromRect: floor.frame)
        floor.physicsBody?.categoryBitMask = PhysicsCategory.Floor
        floor.physicsBody?.collisionBitMask = PhysicsCategory.All
        floor.physicsBody?.restitution = 0.3;
        floor.physicsBody?.dynamic = false
        
        addChild(floor)
    }
    
    func addMonster(){
        var monster = SKSpriteNode(imageNamed: "monster.png")
        monster.position = CGPoint(x: size.width * 0.995, y: size.height * 0.1)
        monster.physicsBody = SKPhysicsBody(rectangleOfSize: monster.size, center: CGPoint(x: monster.size.width*0.15, y: monster.size.height*0.15))
        monster.physicsBody?.categoryBitMask = PhysicsCategory.Monster
        monster.physicsBody?.collisionBitMask = PhysicsCategory.Floor | PhysicsCategory.Player
        monster.physicsBody?.contactTestBitMask = PhysicsCategory.Player
        monster.physicsBody?.dynamic = true
        
        addChild(monster)
        
        let actualDuration = random(min: CGFloat(2.5), max: CGFloat(3.2))
        
        //let moveAction = SKAction.moveTo(CGPoint(x: 0, y: monster.position.y), duration: NSTimeInterval(actualDuration))
        let moveAction = SKAction.moveBy(CGVector(dx: -size.width * 0.01, dy: 0), duration: 0.022)
        let dieAction = SKAction.removeFromParent()
        
        
        //monster.runAction(SKAction.sequence([moveAction, dieAction]))
        monster.runAction( SKAction.sequence([ SKAction.repeatAction(moveAction, count: 100), dieAction ]))
        //monster.runAction(SKAction.repeatActionForever(SKAction.sequence([moveAction, SKAction.waitForDuration(0.005)])))
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == PhysicsCategory.Player && contact.bodyB.categoryBitMask == PhysicsCategory.Monster {
            println("Sup m8")
        }
        else if contact.bodyB.categoryBitMask == PhysicsCategory.Player && contact.bodyA.categoryBitMask == PhysicsCategory.Monster{
            println("Sup m8")
        }
        
        if contact.bodyA.categoryBitMask == PhysicsCategory.Player || contact.bodyB.categoryBitMask == PhysicsCategory.Player{
            playerFooting++
        }
        
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == PhysicsCategory.Player || contact.bodyB.categoryBitMask == PhysicsCategory.Player{
            playerFooting--
        }
    }
    
    
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
}
