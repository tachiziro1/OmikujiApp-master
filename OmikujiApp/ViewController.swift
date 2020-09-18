//
//  ViewController.swift
//  OmikujiApp
//
//  Created by たっくん on 2020/09/13.
//  Copyright © 2020 tatsuya.com. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    var resultAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    

    @IBOutlet weak var stickView: UIView!
    
    @IBOutlet weak var stickLabel: UILabel!
    
    @IBOutlet weak var stickHeight: NSLayoutConstraint!
    
    @IBOutlet weak var stickBottomMargin: NSLayoutConstraint!
    
    @IBOutlet weak var overView: UIView!
    
    
    @IBOutlet weak var bigLabel: UILabel!
    
     let resultTexts: [String] = [
           "大吉",
           "中吉",
           "小吉",
           "吉",
           "末吉",
           "凶",
           "大凶"
       ]
       
       override func viewDidLoad() {
           super.viewDidLoad()
         setupSound() //この1行を追加
           // Do any additional setup after loading the view, typically from a nib.
       }
       
       override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
           
           if motion != UIEvent.EventSubtype.motionShake || overView.isHidden == false {
               // シェイクモーション以外では動作させない
               // 結果の表示中は動作させない
               return
           }
           
           let resultNum = Int( arc4random_uniform(UInt32(resultTexts.count)) )
           stickLabel.text = resultTexts[resultNum]
           stickBottomMargin.constant = stickHeight.constant * -1
           
           UIView.animate(withDuration: 1.0, animations: {
               
               self.view.layoutIfNeeded()
               
               }, completion: { (finished: Bool) in
                   self.bigLabel.text = self.stickLabel.text
                   self.overView.isHidden = false
                //次の1行を追加 -> 結果表示のときに音を再生(Play)する
                           self.resultAudioPlayer.play()
           })
       }
    
    
    
    @IBAction func tapRetryButton(_ sender: Any) {
   overView.isHidden = true
        stickBottomMargin.constant = 0}
    
        func setupSound() {
            if let sound = Bundle.main.path(forResource: "drum", ofType: ".mp3") {
                resultAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
                resultAudioPlayer.prepareToPlay()
            }
        }
        
    }


