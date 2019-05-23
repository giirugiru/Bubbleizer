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
    
    var audioPlayer: AVAudioPlayer?
    var audioPlayer2: AVAudioPlayer?
    
//    @IBOutlet weak var SpawnBubbleOutlet: UIButton! //OUTLET BUTTON BUAT SPAWN BUBBLE
    @IBOutlet weak var TapAnywhereLabel: UILabel!
    
    
    /*@IBAction func SpawnBubbleButton(_ sender: UIButton) { //FUNCTION BUAT SPAWN BUBBLE KALO DI TOUCH
        spawnBubbleButtonAnimation()
        spawnBubble()
        playSoundBubbleSpawn()

    }*/
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { //TAP DIMANA AJA, BISA MUNCUL BUBBLE
        if let touch = touches.first {
            let position = touch.location(in: view)
            print(position)
            
            let randomSize = CGFloat.random(in: 30...150)
            let bubbleView = UIImageView(frame: CGRect(x: position.x, y: position.y, width: randomSize, height: randomSize))
            
            bubbleView.image = UIImage(named: "blueBubble") //MANGGIL IMAGE FILE DARI ASSETS
            UIView.transition(with: self.view, duration: 0.5, options: [.transitionCrossDissolve], animations: {
                self.view.addSubview(bubbleView) //MUNCULIN BUBBLE NYA
            }, completion: nil)
            
            playSoundBubbleSpawn()
            tapAnywhereLabelAnimation()
            
            //GESTURE RECOGNIZER
            /*let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
            bubbleView.isUserInteractionEnabled = false
            bubbleView.addGestureRecognizer(singleTap)*/
            
            
            //ANIMASI FLOATING BUBBLE
            let bubblePath = UIBezierPath() //PATH BUAT ANIMASINYA
            bubblePath.move(to: CGPoint(x: position.x, y: position.y)) //POSISI AWAL BUBBLE MUNCUL
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
    
    //ANIMASI BUAT LABEL NYA
    func tapAnywhereLabelAnimation(){
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
        self.TapAnywhereLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (true) in
        UIView.animate(withDuration: 0.4, animations: {
        self.TapAnywhereLabel.transform = CGAffineTransform.identity
            })
        }
    }
    
    //FUNCTION BUAT SFX BUBBLE SPAWN
    func playSoundBubbleSpawn() {
        let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: "BubbleSpawning", ofType: "mp3")!)
        print(alertSound)
        
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        try! AVAudioSession.sharedInstance().setActive(true)
        
        try! audioPlayer = AVAudioPlayer(contentsOf: alertSound)
        audioPlayer!.prepareToPlay()
        audioPlayer!.play()
    }
    
    //FUNCTION BUAT SFX BUBBLE POP
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

