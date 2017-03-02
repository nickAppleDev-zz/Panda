//
//  GameScene.swift
//  panda
//
//  Created by i-Techsys.com on 16/12/6.
//  Copyright © 2016年 i-Techsys. All rights reserved.
//

import SpriteKit
import GameplayKit

let MGScreenW = UIScreen.main.applicationFrame.size.width
let MGScreenH = UIScreen.main.applicationFrame.size.height

protocol ProtocolGameScene: NSObjectProtocol {
    func onGetData(dis: CGFloat)
}


extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == BitMaskType.platform | BitMaskType.panda {
            panda.run()
            
            panda.jumpEnd = panda.position.y
            if panda.jumpEnd - panda.jumpStart <= -70 {
                panda.roll()
            }
            print("panda.jumpEnd - panda.jumpStart = \(panda.jumpEnd - panda.jumpStart)")
        }

        
        
        if contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == BitMaskType.sence | BitMaskType.panda {
            NotificationCenter.default.post(name: NSNotification.Name("GameOverNotification"), object: nil, userInfo: nil)
            print("Game Over")
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        panda.jumpStart = panda.position.y
    }
}

class GameScene: SKScene {

    /// 熊猫
    lazy var panda = Panda()
    /// 平台工厂🏭
    lazy var platformFactor = PlatformFactor()
    lazy var bg = BackGroundBG()
    
    /// 平台移动速度
    fileprivate var moveSpeed: CGFloat = 15
    var lastDis = 0.0
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        let skyColor = SKColor(colorLiteralRed: 113/255, green: 197/255, blue: 207/255, alpha: 1.0)
        self.backgroundColor = skyColor
        
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = BitMaskType.sence
        self.physicsBody?.isDynamic = false
        
        addChild(bg)
        bg.position = CGPoint(x: -MGScreenW, y: -MGScreenH)
        bg.zPosition = 20
        
        self.addChild(panda)
        panda.zPosition = 40
        panda.position = CGPoint(x: 100, y: 50)
        
        self.addChild(platformFactor)
        platformFactor.delegate = self
        platformFactor.zPosition = 30
        platformFactor.createPlatform(midNum: 3, x: -30, y:  -200)
        platformFactor.sceneWidth = MGScreenW*0.15
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        switch panda.status {
//            case .run:
//                panda.roll()
//            case .roll:
//                panda.jump()
////            case .jump:
////                panda.run()
//            default:
//                break
//        }
        panda.jump()
    }
    
    override func update(_ currentTime: TimeInterval) {
        bg.move(moveSpeed/5)
        
        lastDis -= Double(moveSpeed)
        if lastDis <= 0 {
            print("生成新平台")
//            platformFactor.creatPlatform1(midNum: 0, x: MGScreenW, y: 200)
            platformFactor.createPlatformRandom()
        }

        platformFactor.move(speed: moveSpeed)
    }
}

extension GameScene: ProtocolGameScene {
    func onGetData(dis distance: CGFloat) {
        self.lastDis = Double(distance)
    }
}
