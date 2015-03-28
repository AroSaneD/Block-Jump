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
    
    func getRandomMonster() -> Monster{
        let index = Global.randomInt(MonsterCategory.max)
        var monster:Monster
        switch index{
        case MonsterCategory.standart:
            monster = Monster(parent: home!)
        case MonsterCategory.jumper:
            monster = Jumper(parent: home!)
        case MonsterCategory.assassin:
            monster = Assassin(parent: home!)
        default:
            monster = Monster(parent: home!)
        }
        
        return monster
    }
    
    func generateMonster(){
        
        
        
        var monster = getRandomMonster()
        
        if isAssassinAlive() {
            while monster.physicsBody!.categoryBitMask == PhysicsCategory.Assassin
            {
                monster = getRandomMonster()
            }
        }
        
        home!.addChild(monster)
        home!.mobs!.append(monster)
        
        monster.beginActions()
        
    }
    
    func isAssassinAlive() -> Bool {
        var assassinAlive = false
        for mob in home!.mobs! {
            if mob.physicsBody!.categoryBitMask == PhysicsCategory.Assassin {
                assassinAlive = true
            }
        }
        return assassinAlive
    }
}