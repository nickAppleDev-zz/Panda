//
//  GameViewController.swift
//  panda
//
//  Created by i-Techsys.com on 16/12/6.
//  Copyright © 2016年 i-Techsys. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    
    var backgroundMusic: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        let musicNameArr = ["hit_platform","hit","apple"]
        let i = Int(arc4random_uniform(UInt32(musicNameArr.count)))
        guard let url = Bundle.main.url(forResource: musicNameArr[i], withExtension: ".mp3") else { return }
        backgroundMusic = try? AVAudioPlayer(contentsOf: url)
        backgroundMusic.numberOfLoops = -1
        backgroundMusic.volume = 1.0
        backgroundMusic.prepareToPlay()
        backgroundMusic.play()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("GameOverNotification"), object: nil, queue: nil) { (_) in
            self.backgroundMusic = nil
            guard let url = Bundle.main.url(forResource: "lose", withExtension: ".mp3") else { return }
            self.backgroundMusic = try? AVAudioPlayer(contentsOf: url)
            self.backgroundMusic.numberOfLoops = 1
            self.backgroundMusic.volume = 1.0
            self.backgroundMusic.prepareToPlay()
            self.backgroundMusic.play()
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscapeLeft
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
