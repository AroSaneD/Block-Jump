//
//  PhysicsCategory.swift
//  sk-gl-mate
//
//  Created by Arūnas Seniucas on 3/18/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import UIKit

struct PhysicsCategory{
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Player    : UInt32 = 0b1        // 1
    static let Monster   : UInt32 = 0b10       // 2
    static let Floor     : UInt32 = 0b100      // 4
    static let Jumper    : UInt32 = 0b1000     // 8
    static let Assassin  : UInt32 = 0b10000    // 16
}
