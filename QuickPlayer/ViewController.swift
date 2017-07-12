//
//  ViewController.swift
//  QuickPlayer
//
//  Created by Tung on 6/20/17.
//  Copyright © 2017 Tung. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, AVAudioPlayerDelegate {
    var status = 1
    @IBOutlet weak var lbl_TimeLeft: UILabel!
    @IBOutlet weak var lbl_TimeRight: UILabel!
    @IBOutlet weak var btn_play: UIButton!
    @IBAction func btn_acction_play(_ sender: UIButton) {
        playPause()
    }
    @IBOutlet weak var sld_outlet_volume: UISlider!
    @IBAction func sld_volume(_ sender: UISlider) {
        print(sender.value)
        audio.volume = sender.value
    }
    @IBOutlet weak var sld_duration: UISlider!
    @IBAction func sld_action_duration(_ sender: UISlider) {
        audio.currentTime = TimeInterval(Float(sender.value) * Float(audio.duration))
    }

    var audio = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        addThumbImgForSlider()
        // Do any additional setup after loading the view, typically from a nib.
        audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType:".mp3")!) as URL)
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    func updateTime(){
        let currentTime = Int(audio.currentTime)
        let minTimeLeft = currentTime/60
        let secTimeLeft = currentTime - minTimeLeft * 60
        self.lbl_TimeLeft.text = String(format: "%02d:%02d", minTimeLeft, secTimeLeft)
        let durationTime = Int(audio.duration)
        let timeRight = durationTime - currentTime
        let minTimeRight = timeRight/60
        let secTimeRight = timeRight - minTimeRight * 60
        self.lbl_TimeRight.text = String(format: "%02d:%02d", minTimeRight,secTimeRight)
        self.sld_duration.value = Float(audio.currentTime/audio.duration)
    }
    func addThumbImgForSlider(){
        sld_outlet_volume.setThumbImage(UIImage(named:"thumb.png"), for: .normal)
        sld_outlet_volume.setThumbImage(UIImage(named:"thumbHightLight.png"), for: .highlighted)
    }
    func playPause(){
        if status == 1{
            btn_play.setImage(UIImage(named: "pause.png"), for: .normal)
            audio.play()
            status = 2
        }else{
            btn_play.setImage(UIImage(named: "play.png"), for: .normal)
            audio.pause()
            status = 1
        }
    }
//    func checkRepeat(){
//        if sw_repeat.isOn == true {
//            audio.numberOfLoops = -1
//        }else{
//            audio.numberOfLoops = 0
//        }
//    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        btn_play.setImage(UIImage(named:"play.png"), for: .normal)
    }

}

