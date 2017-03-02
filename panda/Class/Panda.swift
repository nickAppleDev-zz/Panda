
import SpriteKit

enum Status: Int {
    case run = 1,jump,jump2,roll
}

class Panda: SKSpriteNode {

    let runAtlas = SKTextureAtlas(named: "run.atlas")
    var runFrames = [SKTexture]()
    
    let jumpAtlas = SKTextureAtlas(named: "jump.atlas")
    var jumpFrames = [SKTexture]()
    
    let rollAtlas = SKTextureAtlas(named: "roll.atlas")
    var rollFrames = [SKTexture]()
    
    var status: Status = .run
    var jumpStart: CGFloat = 0.0
    var jumpEnd: CGFloat = 0.0

    init() {
        let texture = runAtlas.textureNamed("panda_run_01")
        let size = texture.size()
        super.init(texture: texture, color: UIColor.white, size: size)
        
        runFrames = action(atlas: runAtlas, imageName: "panda_run_")
        jumpFrames = action(atlas: jumpAtlas, imageName: "panda_jump_")
        rollFrames = action(atlas: rollAtlas, imageName: "panda_roll_")
        
//        self.physicsBody = SKPhysicsBody(rectangleOf: texture.size())
//        self.physicsBody?.isDynamic = true
//        self.physicsBody?.allowsRotation = false
//        // 摩擦力
//        self.physicsBody?.restitution = 0
//        self.physicsBody?.categoryBitMask = BitMaskType.pand
//        self.physicsBody?.contactTestBitMask = BitMaskType.sence | BitMaskType.panda
//        self.physicsBody?.collisionBitMask = BitMaskType.platform
        self.physicsBody = SKPhysicsBody(rectangleOf: texture.size())
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
        //摩擦力
        self.physicsBody?.restitution = 0
        self.physicsBody?.categoryBitMask = BitMaskType.panda  // 设置物理
        self.physicsBody?.contactTestBitMask = BitMaskType.sence | BitMaskType.platform // 包含
        self.physicsBody?.collisionBitMask = BitMaskType.platform   // 作用↔️在平台上
        
        run()
    }
    
    func action(atlas: SKTextureAtlas, imageName: String) -> [SKTexture] {
        var actionFrames = [SKTexture]()
        for index in 1 ... atlas.textureNames.count {
            let tempName =  "\(imageName)" + String(format: "%.2d", index)
            let runTexture = atlas.textureNamed(tempName)
            actionFrames.append(runTexture)
        }
        return actionFrames
    }
    
    // MARK: - Action
    func run() {
        self.removeAllActions()
        self.status = .run
        self.run(SKAction.repeatForever(SKAction.animate(with: runFrames, timePerFrame: 0.05)))
    }
    
    func jump() {
        self.removeAllActions()
        if status != Status.jump2 {
            self.run(SKAction.animate(with: jumpFrames, timePerFrame: 0.05))
            self.physicsBody?.velocity = CGVector(dx: 0, dy: 450)
            if status == Status.jump {
                status = Status.jump2
                self.jumpStart = self.position.y
            }else {
                status = Status.jump
            }
        }else {
//            DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
//                self.run(SKAction.repeatForever(SKAction.animate(with: self.runFrames, timePerFrame: 0.05)))
//            })
        }
    }
    
    func roll() {
        self.removeAllActions()
        self.status = .roll
        self.run(SKAction.animate(with: rollFrames, timePerFrame: 0.05), completion: { () in
            self.run()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
