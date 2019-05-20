//
//  ViewController.swift
//  EmotionApp
//
//  Created by Gilang Sinawang on 10/05/19.
//  Copyright © 2019 Gilang Sinawang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    var imageView: UIImageView = []
    @IBOutlet weak var SpawnBubbleOutlet: UIButton! //OUTLET BUTTON BUAT SPAWN BUBBLE
    @IBAction func SpawnBubbleButton(_ sender: UIButton) { //FUNCTION BUAT SPAWN BUBBLE KALO DI TOUCH
        spawnBubble()
    }
    
    
    /*lazy var bubbleImageView: UIImageView = { // LAZY VARIABLE = DI INITIALIZE KALO DIPANGGIL DOANG
        
        return imageView
    }()*/

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let pokeBubble = UITapGestureRecognizer(target: self, action: #selector(ViewController.))
    }

    
    func spawnBubble(){ //FUNCTION BUAT SPAWN BUBBLE
        //IPHONE XR ORIGINAL SIZE 414x896
         //MANGGIL IMAGE FILE DARI ASSETS //RANDOMIZE UKURAN BUBBLE NYA
        let randomSize = CGFloat.random(in: 30...100)
        let imageView = UIImageView(frame: CGRect(x: .random(in: 25...389), y: .random(in: 25...871), width: randomSize, height: randomSize))
        imageView.image = UIImage(named: "blueBubble")
        UIView.transition(with: self.view, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            self.view.addSubview(imageView)
        }, completion: nil)
//        self.view.addSubview(imageView) //SPAWN BUBBLE NYA

        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(singleTap)
        
        
        //ANIMASI FLOATING BUBBLE
        
       let bubblePath = UIBezierPath()
        bubblePath.move(to: CGPoint(x: .random(in: 25...389), y: 871))
        bubblePath.addCurve(to: CGPoint(x: .random(in: 25...389), y: .random(in: 25...871)), controlPoint1: CGPoint(x: .random(in: 25...389), y: .random(in: 25...871)), controlPoint2: CGPoint(x: .random(in: 25...389), y: .random(in: 25...871)))
        let anim = CAKeyframeAnimation(keyPath: "position")
        anim.path = bubblePath.cgPath
        anim.rotationMode = CAAnimationRotationMode.rotateAuto
//        anim.repeatCount = Float.infinity
        anim.duration = 50
        imageView.layer.add(anim, forKey: "animate position along path")
        
        //        bubbleImageView.isUserInteractionEnabled = true
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: <#T##Any?#>, action: <#T##Selector?#>)
//        bubbleImageView.isUserInteractionEnabled = true
//        bubbleImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func tapDetected(bubble: UITapGestureRecognizer){
//        print(bubble)
        print("tap detected")
//        bubble.view?.alpha = 0
//        bubble.view?.removeFromSuperview()
//        UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: {
//            bubble.view?.frame = CGRect(x: (bubble.view?.frame.origin.x)! + 10, y: (bubble.view?.frame.origin.y)!, width: (bubble.view?.frame.width)!, height: (bubble.view?.frame.height)!)
//        }) { (true) in
//            UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: {
//                bubble.view?.frame = CGRect(x: (bubble.view?.frame.origin.x)! - 10, y: (bubble.view?.frame.origin.y)!, width: (bubble.view?.frame.width)!, height: (bubble.view?.frame.height)!)
//            })
            bubble.view?.alpha = 1
//
//        }
    }
    
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

