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
    var mobs:[SKSpriteNode]?
    var monsterFactory: MonsterFactory?
    
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
        mobs = []
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        physicsWorld.gravity = CGVector(dx: 0, dy: -7.8)
        addPlayer()
        addGround()
        cDelegate = CustomContactDelegate(parent: self)
        physicsWorld.contactDelegate = cDelegate!
        monsterFactory = MonsterFactory(parent: self)
        
        
        
        
        runAction(SKAction.repeatActionForever(  //monsterFactory.generateMonster))
            SKAction.sequence([
                SKAction.runBlock(monsterFactory!.generateMonster /*{ self.addMonster(self.goodInteger) } */),
                SKAction.waitForDuration(NSTimeInterval(Global.random(min: 0.8, max: 1.5)))
                ])
            ))
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if player!.playerFooting > 0 {
            player!.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 4))
        }
        var touch = touches.anyObject() as UITouch
        touchPoint = touch.locationInNode(self)
        
        //player.runAction(jumpAction)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        var currentTouchPoint = touch.locationInNode(self)
        
        var difference = touchPoint!.y - currentTouchPoint.y //CGPoint(x: touchPoint!.x - currentTouchPoint.x, y: touchPoint!.y - currentTouchPoint.x)
        if player?.playerFooting == 0 {
            if(currentTouchPoint.x < player!.frame.minX && touchPoint!.x < player!.frame.minX){
                player!.physicsBody?.applyAngularImpulse(difference * -0.001)
                //player!.physicsBody?.applyTorque(difference * -0001)
            }
            else{
                player!.physicsBody?.applyAngularImpulse(difference * 0.001)
                //player!.physicsBody?.applyTorque(difference * 0001)
            }
        }
        

        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if(player!.frame.midX < 0  || player!.frame.midY < 0){
            println("Game over, m8")
            removeMob(player!)
            controller?.displayEndScene()
        }
        
        let screenScale:CGFloat = 0.75
        if(player!.frame.midX > size.width*screenScale){
            let diff:CGFloat = player!.frame.midX - size.width*screenScale
            for mob in mobs!{
                mob.runAction(SKAction.moveByX(-1*diff, y: 0, duration: 0.2))
            }
        }
    }
    
    
    
    func addPlayer(){
        player = Player(imageName: "player.png", parent: self)

        addChild(player!)
        mobs?.append(player!)
    }
    
    
    
    func addGround(){
        //var floor = SKShapeNode(CGRect(x: 0, y: 0, width: size.width, height: size.height * 0.01))
        var floor = SKSpriteNode(color: SKColor.blackColor(), size: CGSize(width: size.width*2, height: size.height * 0.01)) //(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height * 0.01))
        floor.position = CGPoint(x: size.width, y: 0)
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
        var monster = Monster(imageName: "monster.png", parent: self)
        addChild(monster)
        mobs?.append(monster)
    }
    
    
    
    func removeMob(mob: SKSpriteNode){
        let index = find(mobs!, mob)
        mobs?.removeAtIndex(index!)
    }
    
    
    
    
}
