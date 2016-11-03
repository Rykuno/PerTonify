//
//  ViewController.swift
//  TonePerfect
//
//  Created by Donny Blaine on 11/2/16.
//  Copyright © 2016 RyStudios. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate {
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordMessage: UILabel!
    
    var audioRecorder:AVAudioRecorder!
    let beginRecordingSound: SystemSoundID = 1113
    let endRecordingSound: SystemSoundID = 1114
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopButton.isEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startAudioRecording(_ sender: Any) {
        setViewStatusForRecording(isRecording: true)

        // plays audabile note indicating recording
        AudioServicesPlaySystemSound(beginRecordingSound)

        //begin recording audio
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopAudioRecording(_ sender: Any) {
        setViewStatusForRecording(isRecording: false)
        
        // play audable note idicating recorder stopping
        AudioServicesPlaySystemSound(endRecordingSound)
        
        //stop recorder
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func setViewStatusForRecording(isRecording: Bool){
        if (isRecording) {
            stopButton.isEnabled = true
            recordMessage.text = "Recording in Process..."
            startButton.isEnabled = false
        }else{
            stopButton.isEnabled = false
            recordMessage.text = "Tap to Record"
            startButton.isEnabled = true
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag) {
        self.performSegue(withIdentifier: "stopRecordingSegue", sender: audioRecorder.url)
        }else{
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecordingSegue" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

