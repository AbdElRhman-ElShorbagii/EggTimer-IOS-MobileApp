//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 5*1 , "Medium": 7*60 , "Hard": 12*60]
    var secoundsPassed = 0
    var totalTime = 0
    var timer = Timer() //we decalared it as a global variable to only execute ones
    var player: AVAudioPlayer!

    @IBOutlet weak var statueLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
       
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!

        //reset code start
        timer.invalidate() // it use to stop and cancel any runing time and making a new one
        progressBar.progress = 0.0
        secoundsPassed = 0
        statueLabel.text = hardness
        //reset code end
                
       timer = Timer.scheduledTimer(timeInterval: 1.0,target: self,selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
    if(secoundsPassed < totalTime) {
        secoundsPassed += 1
        let percentageProgress = Float(secoundsPassed) / Float(totalTime)
        print(percentageProgress)
        progressBar.progress = percentageProgress
    }
    else{
        timer.invalidate() // it use to stop and cancel any runing time and making a new one
        statueLabel.text = "Done"
        playSound()
        }
    }
    
    func playSound(){
        let url = Bundle.main.url(forResource: "alarm_sound" , withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    
    }
}
