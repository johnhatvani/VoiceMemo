//
//  RecordingViewController.swift
//  VoiceMemo
//
//  Created by John Hatvani on 16/9/21.
//

import Foundation
import UIKit
import DSWaveformImage
import AVFoundation

public class RecordingViewController: UIViewController {
    lazy var theme = getTheme()
    
    lazy var appDelegate: AppDelegate = {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError("no app delegate")  }
        return appdelegate
    }()
    
    var recording: Recording?
    
    @IBOutlet weak var waveformImage: UIImageView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var transcriptArea: UITextView!
    
    var player: AVAudioPlayer!
        
    let waveformImageDrawer = WaveformImageDrawer()
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = theme.primaryBackground
        transcriptArea.textColor = theme.titleColor
        playPauseButton.backgroundColor = theme.buttonPrimary.backgroundColor
        playPauseButton.layer.cornerRadius = theme.buttonPrimary.cornerRadius
        playPauseButton.tintColor = theme.buttonPrimary.tintColor
        playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playPauseButton.setImage(UIImage(systemName: "stop.fill"), for: .selected)
       
        deleteButton.backgroundColor = theme.buttonPrimary.backgroundColor
        deleteButton.layer.cornerRadius = theme.buttonPrimary.cornerRadius
        deleteButton.tintColor = theme.buttonPrimary.tintColor
        
        guard let recording = recording else {
            navigationController?.popToRootViewController(animated: true)
            return
        }
        
        title = recording.datetime?.recordingListFormat()
        transcriptArea.text = recording.transcript
    
        let audioURL = recording.getAudioURL()
        // show the playback waveform
        waveformImage.generateWaveFile(fromURL: audioURL)
        
        // setup audio playback
        do {
            player = try AVAudioPlayer(contentsOf: audioURL)
            player.delegate = self;
            player.prepareToPlay()
        } catch let error {
            print(error.localizedDescription)
        }
        
        pressPlayStop(playPauseButton)
        
    }
    
    @IBAction func pressPlayStop(_ sender: UIButton) {
        playPauseButton.isSelected = !playPauseButton.isSelected
        if !playPauseButton.isSelected {
            player.stop()
            player.currentTime = 0
            return
            
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio)
            try AVAudioSession.sharedInstance().setActive(true)
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func deleteRecord(_ sender: Any) {
        appDelegate.persistentContainer.viewContext.delete(recording!)
        navigationController?.popViewController(animated: true)
    }
}

extension RecordingViewController: AVAudioPlayerDelegate {
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playPauseButton.isSelected = false
    }
}

