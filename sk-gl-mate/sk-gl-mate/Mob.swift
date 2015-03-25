//
//  Mob.swift
//  sk-gl-mate
//
//  Created by Arūnas Seniucas on 3/21/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class Mob: SKSpriteNode {
    
    var playerFooting:NSInteger = 0;
    var home:GameScene?
    var mobSize:CGFloat = 0.075 
    
    init(parent: GameScene){
        super.init(
            texture: nil,
            color: UIColor.redColor(),
            size: CGSize(width: CGFloat(parent.size.height * mobSize), height: CGFloat(parent.size.height * mobSize)))
        
        home  = parent
        
        //
        
        
        /*let test = SKSpriteNode(
            texture: SKTexture("monster.png")!,
            color: UIColor.redColor(),
            size: CGSize(width: parent.size.width * mobSize, height: parent.size.height * mobSize))*/
        /*
        super.init(texture: SKTexture("monster.png"),color: SKColor.redColor(), size: CGSize(width: parent.size.width * mobSize, height: parent.size.height * mobSize))
        */
        
        
        physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        physicsBody?.restitution = 0
        physicsBody?.dynamic = true
        
        physicsBody?.collisionBitMask = PhysicsCategory.Floor | PhysicsCategory.Monster | PhysicsCategory.Player
        physicsBody?.contactTestBitMask = PhysicsCategory.Floor | PhysicsCategory.Monster | PhysicsCategory.Player
        
        self.name = "mob"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func jump(){
        if playerFooting > 0{
            self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 4.5))
        }
    }
    
}
