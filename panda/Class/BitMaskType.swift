//
//  BitMaskType.swift
//  panda
//
//  Created by i-Techsys.com on 16/12/8.
//  Copyright © 2016年 i-Techsys. All rights reserved.
//  物理虚拟世界

import UIKit

class BitMaskType {
    /// 熊猫🐼
    class var panda: UInt32 {
        return 1<<0
    }
    
    /// 平台🏭
    class var platform: UInt32 {
        return 1<<1
    }
    
    /// 苹果🍎
    class var apple: UInt32 {
        return 1<<2
    }
    
    /// 场景😞
    class var sence: UInt32 {
        return 1<<3
    }
}
