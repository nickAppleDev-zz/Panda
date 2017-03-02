//
//  PlatformFactor.swift
//  panda
//
//  Created by i-Techsys.com on 16/12/6.
//  Copyright © 2016年 i-Techsys. All rights reserved.
// 

import SpriteKit

class PlatformFactor: SKNode {
    let leftTexture   = SKTexture(imageNamed: "platform_l")
    let midTexture    = SKTexture(imageNamed: "platform_m")
    let rightTexture  = SKTexture(imageNamed: "platform_r")
    
    // 平台数组
    var platforms = [Platform]()
    
    var sceneWidth: CGFloat = 0
    weak var delegate: ProtocolGameScene?
    
    func createPlatformRandom() {
        //随机平台的长度1-4
        let midNum: UInt32 = arc4random()%4 
//        print("平台的长度:\(midNum)")
        
        //随机间隔1-8
        //let gap: CGFloat = CGFloat(Float(arc4random()%8 + 1))
        let gap: CGFloat = CGFloat(arc4random()%8 + 1) //beta 5
//        print("随机间隔: \(gap)")
        
        //x坐标
        //let x: CGFloat = self.sceneWidth + CGFloat(Float(midNum*50)) + gap + 100//
        let x: CGFloat = self.sceneWidth + CGFloat(midNum*50) + gap + 100 //beta5
        print("x坐标: \(x)")
        
        //y坐标200-400
        //let y: CGFloat = CGFloat(Float(arc4random()%201 + 200))
        let y: CGFloat = CGFloat(arc4random()%200) - MGScreenH + 200
        print("y坐标: \(y)")
        
        createPlatform(midNum: midNum, x: x, y: y)
    }

    func createPlatform(midNum: UInt32, x: CGFloat, y: CGFloat) {
        let platform = Platform()
        platform.position = CGPoint(x: x, y: y)
        
        let platform_left = SKSpriteNode(texture: leftTexture)
        platform_left.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        let platform_right = SKSpriteNode(texture: rightTexture)
        platform_right.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        var arrPlatform = [SKSpriteNode]()
        arrPlatform.append(platform_left)
        for _ in 0...midNum {
            let platform_mid = SKSpriteNode(texture: midTexture)
            platform_mid.anchorPoint = CGPoint(x: 0, y: 0.5)
            arrPlatform.append(platform_mid)
        }
        arrPlatform.append(platform_right)
        
        platform.OnCreat(arrPlatform: arrPlatform)
        self.addChild(platform)
        
        platforms.append(platform)
        
        /// 通用公式:平台的长度 + x坐标-主场景的宽度
        delegate?.onGetData(dis: platform.width + x - sceneWidth)
    }

    
    func creatPlatform1(midNum: UInt32, x: CGFloat, y: CGFloat)  {
        // 1.产生平台
        let platform = Platform()
        platform.position = CGPoint(x: x, y: y)
        
        // 左边纹理
        let platform_left = SKSpriteNode(texture: leftTexture)
        platform_left.anchorPoint = CGPoint(x: 0, y: 0.9)
        
        // 右边纹理
        let platform_right = SKSpriteNode(texture: rightTexture)
        platform_left.anchorPoint = CGPoint(x: 0, y: 0.9)
        
        /// 2.拼接最左边的平台
        var arrPlatform = [SKSpriteNode]()
        arrPlatform.append(platform_left)
        
        // 3.拼接中间有几个平台
        for _ in 0...midNum {
            // 中间纹理
            let platform_mid = SKSpriteNode(texture: midTexture)
            platform_mid.anchorPoint = CGPoint(x: 0, y: 0.9)
            arrPlatform.append(platform_mid)
        }
        
        // 4.拼接最右边的平台
        arrPlatform.append(platform_right)
        platform.OnCreat(arrPlatform: arrPlatform)
        self.addChild(platform)
        
        // 5.讲平台添加到数组
        platforms.append(platform)
        /// 调用公式： 平台宽度 + X - senceWidth
        delegate?.onGetData(dis: CGFloat(platform.width) + x - sceneWidth)
    }

    /// 平台移动（根据外界传过来的速度移动）
    func move(speed: CGFloat) {
        //
        for p in platforms {
            p.position.x -= speed
        }
        
        /// 从父控件中移除，并且从数组中移除
        if platforms[0].position.x  + platforms[0].width/2 <= -platforms[0].width {
            print(platforms[0].position.x)
            print(-platforms[0].width)
            platforms[0].removeFromParent()
            platforms.remove(at: 0)
        }
    }
}
