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
    
    init(imageName: NSString, parent: GameScene){
        home  = parent
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
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
