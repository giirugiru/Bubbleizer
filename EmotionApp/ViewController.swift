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
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        imageView.isUserInteractionEnabled = true
        
        imageView.image = UIImage(named: "blueBubble")
        imageView.addGestureRecognizer(singleTap)
        self.view.addSubview(imageView) //SPAWN BUBBLE NYA
        
        //        bubbleImageView.isUserInteractionEnabled = true
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: <#T##Any?#>, action: <#T##Selector?#>)
//        bubbleImageView.isUserInteractionEnabled = true
//        bubbleImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func tapDetected(bubble: UITapGestureRecognizer){
//        print(bubble)
        print("tap detected")
        bubble.view?.alpha = 0
//        bubble.view?.removeFromSuperview()
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

