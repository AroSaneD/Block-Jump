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
    var lastKnownPosition: Float = 0
    var distanceTravelled: Float = 0
    var score:SKLabelNode?
    var lastWallPlacedAt: Float = 0
    

    
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
        physicsWorld.gravity = CGVector(dx: 0, dy: -5.8)
        addPlayer()
        addGround()
        addCeiling()
        addScore()
        lastKnownPosition = Float(player!.frame.midX)
        cDelegate = CustomContactDelegate(parent: self)
        physicsWorld.contactDelegate = cDelegate!
        monsterFactory = MonsterFactory(parent: self)
        
        
        startMonsterGeneration()
        startPointEarning()
        startWallGeneration()
        
        
        
        
        
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if player!.playerFooting > 0 {
            //player!.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 4))
        }
        var touch = touches.anyObject() as UITouch
        touchPoint = touch.locationInNode(self)
        
        //player.runAction(jumpAction)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        var currentTouchPoint = touch.locationInNode(self)
        
        var difference = touchPoint!.y - currentTouchPoint.y
        let vectorReduction: CGFloat = 10
        var directionVector = CGVector(dx: (currentTouchPoint.x - touchPoint!.x)/(vectorReduction*4), dy:(currentTouchPoint.y - touchPoint!.y) / vectorReduction)
        
        player!.jump(directionVector)
        
        //if player!.playerFooting > 0 { player!.physicsBody!.applyImpulse(directionVector)}
        
        /*
        //CGPoint(x: touchPoint!.x - currentTouchPoint.x, y: touchPoint!.y - currentTouchPoint.x)
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
        */

        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        //Calculates distance travelled
        distanceTravelled += Float(Float(player!.frame.midX) - lastKnownPosition)
        lastKnownPosition = Float(player!.frame.midX)
        score!.text = "\(Int(distanceTravelled))"
        
        //If outside left border
        if(player!.frame.midX < 0  || player!.frame.midY < 0){
            removeMob(player!)
            gameOver()
        }
        
        
        //If outside right border
        let screenScale:CGFloat = 0.5
        if(player!.frame.midX > size.width*screenScale){
            let diff:CGFloat = player!.frame.midX - size.width*screenScale
            distanceTravelled += Float(diff)
            for mob in mobs!{
                mob.runAction(SKAction.moveByX(-1*diff, y: 0, duration: 0))
            }
        }
        
        //
        
        println("\(mobs!.count)")
        
    }
    
    
    
    func addPlayer(){
        player = Player(parent: self)

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
        floor.physicsBody?.friction = 0.3
        floor.physicsBody?.dynamic = false
        
        addChild(floor)
    }
    
    func addCeiling(){
        //var floor = SKShapeNode(CGRect(x: 0, y: 0, width: size.width, height: size.height * 0.01))
        var floor = SKSpriteNode(color: SKColor.blackColor(), size: CGSize(width: size.width*2, height: size.height * 0.01)) //(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height * 0.01))
        floor.position = CGPoint(x: size.width, y: size.height)
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
    
    func addScore(){
        score = SKLabelNode(fontNamed: "Helvetica")

        score!.text = "0"
        score!.fontColor = SKColor.blueColor()
        score!.fontSize = 30
        score!.position = CGPoint(x: size.width - score!.frame.width/2, y: size.height - score!.frame.height)
        score!.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        score!.zPosition = 1
        addChild(score!)
        
    }
    
    func removeMob(mob: SKSpriteNode){
        let index = find(mobs!, mob)
        mobs?.removeAtIndex(index!)
    }
    
    func gameOver(){
        controller!.honorPoints += Int(distanceTravelled/1000)
        controller!.displayEndScene()
    }
    
    func startMonsterGeneration(){
        runAction(SKAction.repeatActionForever(  //monsterFactory.generateMonster))
            SKAction.sequence([
                SKAction.runBlock(monsterFactory!.generateMonster /*{ self.addMonster(self.goodInteger) } */),
                SKAction.waitForDuration(NSTimeInterval(Global.random(min: 0.8, max: 1.5)))
                ])
            ))
    }
    
    func startPointEarning(){
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock({ self.distanceTravelled += 1}),
                SKAction.waitForDuration(0.05)
                ])
            ))
    }
    
    func startWallGeneration(){
        
        
        runAction(SKAction.repeatActionForever(
            
            SKAction.sequence([
                SKAction.runBlock({
                    if self.distanceTravelled > 3500 {
                        if self.lastWallPlacedAt + 400 < self.distanceTravelled{
                            let index = Global.randomInt(2)
                            var wall = SKSpriteNode(color: SKColor.blackColor(), size: CGSize(width: self.size.width / 20, height: Global.random(min: self.size.height / 10, max: self.size.height / 2)))
                            
                            wall.physicsBody = SKPhysicsBody(rectangleOfSize: wall.size)
                            wall.physicsBody!.restitution = 0.01
                            wall.physicsBody!.dynamic = false
                            //wall.physicsBody!.affectedByGravity = false
                            wall.physicsBody!.categoryBitMask = PhysicsCategory.Floor
                            wall.physicsBody!.collisionBitMask = PhysicsCategory.All
                            wall.physicsBody!.contactTestBitMask = PhysicsCategory.All
                            wall.name = "wall"
                            
                            switch index {
                            case 0:
                                wall.position = CGPoint(x: self.size.width, y: 0)
                            default:
                                wall.position = CGPoint(x: self.size.width, y: self.size.height - wall.size.height/2)
                            }
                            self.lastWallPlacedAt = self.distanceTravelled
                            self.mobs!.append(wall)
                            self.addChild(wall)
                            var moveAction = SKAction.moveBy(CGVector(dx: self.size.width * -0.01, dy: 0.01), duration: 0.022)
                            wall.runAction(SKAction.sequence([
                                SKAction.repeatAction(moveAction, count: 300),
                                SKAction.runBlock({ self.removeMob(wall) }),
                                SKAction.runBlock(wall.removeFromParent)
                                ]))
                        }
                    }
                    
                }),
                SKAction.waitForDuration(0.2)
                ])
            ))
    }
    
    
    
    
}
