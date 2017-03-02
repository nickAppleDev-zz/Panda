
import SpriteKit

class Platform: SKNode {

    var width: CGFloat = 0.0
    var height: CGFloat = 10.0
    
    /// 产生平台
    func OnCreat(arrPlatform: [SKSpriteNode]) {
        for platform in arrPlatform {
            platform.position.x = CGFloat(self.width)
            self.addChild(platform)
            self.width += platform.size.width
        }
        
//        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.width,height: self.height), center: CGPoint(x: self.width/2, y: 0))
//        self.physicsBody?.categoryBitMask = BitMaskType.platform
//        self.physicsBody?.isDynamic = false
//        self.physicsBody?.allowsRotation = false
//        self.physicsBody?.restitution = 0
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.width, height: self.height), center: CGPoint(x: self.width/2, y: 0))
        self.physicsBody?.categoryBitMask = BitMaskType.platform
        self.physicsBody?.isDynamic = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0

    }


}
