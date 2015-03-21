//
//  Jumper.swift
//  sk-gl-mate
//
//  Created by Arūnas Seniucas on 3/21/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class Jumper : Monster{
    
    override init(imageName: NSString, parent: GameScene) {
        super.init(imageName: imageName, parent: parent)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func logic() {
        if (home!.player!.frame.midX + self.frame.width*4) > self.frame.midX {
            jump()
        }
    }
    
    
}
