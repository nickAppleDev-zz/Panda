//
//  BackGroundBG.swift
//  panda
//
//  Created by i-Techsys.com on 16/12/8.
//  Copyright © 2016年 i-Techsys. All rights reserved.
//

import SpriteKit

class BackGroundBG: SKNode {
    // 近景背景数组
    var arrNearBG = [SKSpriteNode]()
    // 远景背景数组
    var arrFarBG  = [SKSpriteNode]()
    
    override init() {
        super.init()
        // 远景背景
        let farTexture = SKTexture(imageNamed: "background_f1")
        
        let farBG0 = creatFarBG(farTexture: farTexture)
        let farBG1 = creatFarBG(farTexture: farTexture)
        let farBG2 = creatFarBG(farTexture: farTexture)
        farBG1.position.x = farBG0.frame.size.width
        farBG2.position.x = farBG0.frame.size.width*2

        arrFarBG.append(farBG0)
        arrFarBG.append(farBG1)
        arrFarBG.append(farBG2)
        self.addChild(farBG0)
        self.addChild(farBG1)
        self.addChild(farBG2)
        
        // 近景背景
        let nearTexture = SKTexture(imageNamed: "background_f0")
        
        let nearBG0 = creatNearBG(nearTexture: nearTexture)
        let nearBG1 = creatNearBG(nearTexture: nearTexture)
        nearBG1.position.x = nearBG0.frame.size.width
        
        arrNearBG.append(nearBG0)
        arrNearBG.append(nearBG1)
        self.addChild(nearBG0)
        self.addChild(nearBG1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 移动和移除
extension BackGroundBG {
    func move(_ speed: CGFloat) {
        // 近景
        for nearBG in arrNearBG {
            nearBG.position.x -= speed
        }
        if arrNearBG[0].position.x + arrNearBG[0].size.width < speed{
            arrNearBG[0].position.x = 0
            arrNearBG[1].position.x = arrNearBG[0].size.width
        }
        
        // 远景
        for farBG in arrFarBG {
            farBG.position.x -= speed/3
        }
        if arrFarBG[0].position.x + arrFarBG[0].size.width < speed {
            arrFarBG[0].position.x = 0
            arrFarBG[1].position.x = arrFarBG[0].size.width
            arrFarBG[2].position.x = arrFarBG[0].size.width*2
        }
    }
}

// MARK: - 快速产生背景图片
extension BackGroundBG {
    fileprivate func creatFarBG(farTexture: SKTexture) -> SKSpriteNode{
        let farBG = SKSpriteNode(texture: farTexture)
        farBG.anchorPoint = CGPoint(x: 0, y: 0)
        farBG.position.y = 150
        return farBG
    }
    
    fileprivate func creatNearBG(nearTexture: SKTexture) ->  SKSpriteNode{
        let nearBG = SKSpriteNode(texture: nearTexture)
        nearBG.anchorPoint = CGPoint.zero
        nearBG.position.y = 70
        return nearBG
    }
}
