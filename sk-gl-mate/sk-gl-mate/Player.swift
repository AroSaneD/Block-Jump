//
//  Player.swift
//  sk-gl-mate
//
//  Created by Arūnas Seniucas on 3/18/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class Player : SKSpriteNode{
    var playerFooting:NSInteger = 0;

    
    /*
    init(imageName: NSString){
    
        super.init(imageNamed: imageName)
        
        position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        //player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)
        //player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size, center: CGPoint(x: player.size.width*0.15, y: player.size.height*0.15))
        physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        physicsBody?.categoryBitMask = PhysicsCategory.Player
        physicsBody?.collisionBitMask = PhysicsCategory.Floor | PhysicsCategory.Monster
        physicsBody?.contactTestBitMask = PhysicsCategory.Floor | PhysicsCategory.Monster
        physicsBody?.restitution = 0
        physicsBody?.dynamic = true

    }
*/
    
}