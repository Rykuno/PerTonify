//
//  PlaySoundsViewController.swift
//  TonePerfect
//
//  Created by Donny Blaine on 11/2/16.
//  Copyright © 2016 RyStudios. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int{ case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch (ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(0.5)
        case .Fast:
            playSound(1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        print("Stop Audio Button Pressed")
        stopAudio()
    }


}
