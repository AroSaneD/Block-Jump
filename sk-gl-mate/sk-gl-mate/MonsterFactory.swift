//
//  MonsterFactory.swift
//  sk-gl-mate
//
//  Created by Arūnas Seniucas on 3/18/15.
//  Copyright (c) 2015 Arūnas Seniucas. All rights reserved.
//

import SpriteKit

class MonsterFactory{
    
    var home: GameScene?
    
    init(parent: GameScene){
        home = parent
    }
    
    func generateMonster(){
        let index = Global.randomInt(MonsterCategory.max)
        var monster:Monster
        switch index{
        case MonsterCategory.standart:
            monster = createStandart()
        case MonsterCategory.jumper:
            monster = createJumper()
        default:
            monster = createStandart()
        }
        
        home!.addChild(monster)
        home!.mobs!.append(monster)
        monster.beginActions()
        
    }
    
    func createStandart() -> Monster{
        var monster = Monster(imageName: "monster.png", parent: home!)
        return monster
    }
    func createJumper() -> Monster{
        var monster = Jumper(imageName: "jumper.png", parent: home!)
        
        return monster
    }
}