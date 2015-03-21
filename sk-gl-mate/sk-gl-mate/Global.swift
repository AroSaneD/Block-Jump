//
//  Global.swift
//  sk-gl-mate
//
//  Created by Arūnas Seniucas on 3/21/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

 class Global {
    
    class func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    class func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    class func randomInt(max: NSInteger) -> NSInteger {
        return Int(arc4random_uniform(UInt32(MonsterCategory.max)))
    }
}
