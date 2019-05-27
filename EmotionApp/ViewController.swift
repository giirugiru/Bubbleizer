//
//  ViewController.swift
//  EmotionApp
//
//  Created by Gilang Sinawang on 10/05/19.
//  Copyright © 2019 Gilang Sinawang. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let notification = UINotificationFeedbackGenerator()
    
    var audioPlayer: AVAudioPlayer? //AUDIO PLAYER VARIABLE FOR BUBBLES PAWN
    var audioPlayer2: AVAudioPlayer? //AUDIO PLAYER VARIABLE FOR BUBBLE POP
    
//    @IBOutlet weak var SpawnBubbleOutlet: UIButton! //OUTLET BUTTON FOR SPAWNING BUBBLES
    @IBOutlet weak var TapAnywhereLabel: UILabel!
    
    
    /*@IBAction func SpawnBubbleButton(_ sender: UIButton) { //FUNCTION BUAT SPAWN BUBBLE KALO DI TOUCH
        spawnBubbleButtonAnimation()
        spawnBubble()
        playSoundBubbleSpawn()

    }*/
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { //BUBBLE WILL SPAWN AT WHERE YOU TAP THE SCREEN
        if let touch = touches.first {
            let position = touch.location(in: view) //TOUCH COORDINATES
            print(position)
            
            let randomSize = CGFloat.random(in: 50...150) //BUBBLE SIZE
            let bubbleView = UIImageView(frame: CGRect(x: position.x, y: position.y, width: randomSize, height: randomSize)) //BUBBLE POSITION
            
            
            //BUBBLE RANDOMIZER
            let randomBubble = Int.random(in: 1...5)
            if randomBubble == 1{
            bubbleView.alpha = 1
            }else{
                bubbleView.alpha = 0.80
            }
            print("bubbleImage\(randomBubble)")
            bubbleView.image = UIImage(named: "bubbleImage\(randomBubble)") //USE IMAGE FILE FROM ASSETS
            UIView.transition(with: self.view, duration: 0.5, options: [.transitionCrossDissolve], animations: {
                self.view.addSubview(bubbleView) //ADDING SUBVIEW FOR THE BUBBLE
            }, completion: nil)
            
            playSoundBubbleSpawn() //BUBBLE SPAWN SFX
            tapAnywhereLabelAnimation() //LABEL ANIMATION
            
            //GESTURE RECOGNIZER
            /*let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
            bubbleView.isUserInteractionEnabled = false
            bubbleView.addGestureRecognizer(singleTap)*/
            
            //PROGRAMATICALLY CIRCLE
            /*let shape = SKShapeNode()
            shape.path = UIBezierPath(roundedRect: CGRect(x: -128, y: -128, width: 256, height: 256), cornerRadius: 64).cgPath
            shape.position = CGPoint(x: frame.midX, y: frame.midY)
            shape.fillColor = UIColor.red
            shape.strokeColor = UIColor.blue
            shape.lineWidth = 10
            addChild(shape)*/
            
            //FLOATING BUBBLE ANIMATION
            let animationDuration = Double.random(in: 7...10)
            let bubblePath = UIBezierPath() //BUBBLE ANIMATION PATH
            bubblePath.move(to: CGPoint(x: position.x, y: position.y)) //BUBBLE FIRST POSITION
            bubblePath.addCurve(to: CGPoint(x: .random(in: 25...389), y: .random(in: 25...871)), controlPoint1: CGPoint(x: .random(in: 25...389), y: .random(in: 25...871)), controlPoint2: CGPoint(x: .random(in: 25...389), y: .random(in: 25...871)))
            
            let anim = CAKeyframeAnimation(keyPath: "position") //ANIMATE OBJECT THROUGH THE BEZIER PATH
            anim.path = bubblePath.cgPath
            //        anim.rotationMode = CAAnimationRotationMode.rotateAuto
            anim.repeatCount = 1
            anim.duration = animationDuration
            //anim.speed = 12.0
            bubbleView.layer.add(anim, forKey: "animate position along path")
            
            
            //BUBBLE EXIT ANIMATION
            CATransaction.begin()
            CATransaction.setCompletionBlock { //BUBBLE WILL SCALE A BIT BEFORE POPPING
                UIView.animate(withDuration: 0.5, delay: animationDuration-2, options: .curveLinear, animations: {
                    bubbleView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                }, completion: { (isFinish) in
                    UIView.animate(withDuration: 0, delay: 0, options: .curveLinear, animations: {
                        bubbleView.alpha = 0
                        self.playSoundBubblePop()
                        self.notification.notificationOccurred(.success)
                    }, completion: nil)
                })
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //ANIMASI BUAT BUTTON NYA
    /*func spawnBubbleButtonAnimation(){
        UIView.animate(withDuration: 0.25, delay: 0, options: [], animations: {
            self.SpawnBubbleOutlet.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (true) in
            UIView.animate(withDuration: 0.25, animations: {
                self.SpawnBubbleOutlet.transform = CGAffineTransform.identity

            })

        }
    }*/
    
    //LABEL ANIMATION FUNCTION
    func tapAnywhereLabelAnimation(){
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
        self.TapAnywhereLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (true) in
        UIView.animate(withDuration: 0.4, animations: {
        self.TapAnywhereLabel.transform = CGAffineTransform.identity
            })
        }
    }
    
    //BUBBLE SPAWN SFX FUNCTION
    func playSoundBubbleSpawn() {
        let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: "BubbleSpawning", ofType: "mp3")!)
        print(alertSound)
        
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        try! AVAudioSession.sharedInstance().setActive(true)
        
        try! audioPlayer = AVAudioPlayer(contentsOf: alertSound)
        audioPlayer!.prepareToPlay()
        audioPlayer!.play()
    }
    
    //BUBBLE POP SFX FUNCTION
    func playSoundBubblePop() {
        let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: "BubblePopping", ofType: "mp3")!)
        print(alertSound)
        
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        try! AVAudioSession.sharedInstance().setActive(true)
        
        try! audioPlayer2 = AVAudioPlayer(contentsOf: alertSound)
        audioPlayer2!.prepareToPlay()
        audioPlayer2!.play()
    }
    
    
    
    /*func spawnBubble(){ //FUNCTION BUAT SPAWN BUBBLE
        //IPHONE XR ORIGINAL SIZE 414x896
        //RANDOMIZE UKURAN BUBBLE NYA
        let randomSize = CGFloat.random(in: 30...150)
//        let randomX = position!.x
//        let randomY = position!.y
        let bubbleView = UIImageView(frame: CGRect(x: position!.x, y: position!.y, width: randomSize, height: randomSize))

        bubbleView.image = UIImage(named: "blueBubble") //MANGGIL IMAGE FILE DARI ASSETS
        UIView.transition(with: self.view, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            self.view.addSubview(bubbleView) //MUNCULIN BUBBLE NYA
        }, completion: nil)
        
        
        //GESTURE RECOGNIZER
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        bubbleView.isUserInteractionEnabled = false
        bubbleView.addGestureRecognizer(singleTap)
        
        
        //ANIMASI FLOATING BUBBLE
        let bubblePath = UIBezierPath() //PATH BUAT ANIMASINYA
        bubblePath.move(to: CGPoint(x: .random(in: 25...389), y: 871))
        bubblePath.addCurve(to: CGPoint(x: .random(in: 25...389), y: .random(in: 25...871)), controlPoint1: CGPoint(x: .random(in: 25...389), y: .random(in: 25...871)), controlPoint2: CGPoint(x: .random(in: 25...389), y: .random(in: 25...871)))
        
        let anim = CAKeyframeAnimation(keyPath: "position") //ANIMATE OBJECT SESUAI PATH NYA
        anim.path = bubblePath.cgPath
//        anim.rotationMode = CAAnimationRotationMode.rotateAuto
        anim.repeatCount = 1
        anim.duration = 12
        //anim.speed = 12.0
        bubbleView.layer.add(anim, forKey: "animate position along path")
        
        
        //BUAT EXIT ANIMATION (BUBBLE NYA OTOMATIS ILANG SETELAH BBRP DETIK
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            UIView.animate(withDuration: 0.5, delay: 10, options: .curveLinear, animations: {
                bubbleView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }, completion: { (isFinish) in
                UIView.animate(withDuration: 0, delay: 0, options: .curveLinear, animations: {
                    bubbleView.alpha = 0
                    self.playSoundBubblePop()
                }, completion: nil)
            })
//            UIView.transition(with: bubbleView, duration: 10, options: [], animations: {
//                bubbleView.alpha = 0
//            }, completion: { (true) in
//            })
        }
//
 
//        let tapGestureRecognizer = UITapGestureRecognizer(target: <#T##Any?#>, action: <#T##Selector?#>)
//        bubbleImageView.isUserInteractionEnabled = true
//        bubbleImageView.addGestureRecognizer(tapGestureRecognizer)
    }*/
    
    //FUNCTION BUAT GESTURE RECOGNIZER
    /*@objc func tapDetected(bubble: UITapGestureRecognizer){
        print(bubble)
        print("tap detected")
        bubble.view?.alpha = 0
        bubble.view?.removeFromSuperview()
        UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: {
            bubble.view?.frame = CGRect(x: (bubble.view?.frame.origin.x)! + 10, y: (bubble.view?.frame.origin.y)!, width: (bubble.view?.frame.width)!, height: (bubble.view?.frame.height)!)
        }) { (true) in
            UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: {
                bubble.view?.frame = CGRect(x: (bubble.view?.frame.origin.x)! - 10, y: (bubble.view?.frame.origin.y)!, width: (bubble.view?.frame.width)!, height: (bubble.view?.frame.height)!)
            })
        bubble.view?.alpha = 1

        }
    }*/
    
//        UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
//            bubbleImageView.alpha = 0
//        }) { (true) in
//            bubbleImageView.alpha = 1
//        }
    
//    func animateBubble(){
//        UIView.animate(withDuration: 10, delay: 0, options: [], animations: {
//          self.bubbleImageView.alpha = 0
//        }, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
//
//
//    }
//
    //    func :imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
//        let tappedImage = tapGestureRecognizer.view as! UIImageView
        // And some actions
        
//    }
    
}

