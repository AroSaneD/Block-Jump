//
//  Player.swift
//  sk-gl-mate
//
//  Created by Arūnas Seniucas on 3/18/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class Player : Mob{
    

    
    
    override init(imageName: NSString, parent: GameScene){
    
        super.init(imageName: imageName, parent: parent)
        
        position = CGPoint(x: home!.size.width * 0.1, y: size.height * 0.5)
        
        physicsBody?.categoryBitMask = PhysicsCategory.Player

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
}