//
//  RecordingViewController.swift
//  VoiceMemo
//
//  Created by John Hatvani on 16/9/21.
//

import UIKit
import AVKit

public class RecordingViewController: UIViewController {
    lazy var theme = getTheme()
    lazy var recognizer = SpeechRecognizer()
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var transcriptArea: UITextView!
    
    
        
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = theme.primaryBackground
        transcriptArea.textColor = theme.titleColor
        recordButton.backgroundColor = theme.buttonPrimary.backgroundColor
        recordButton.layer.cornerRadius = theme.buttonPrimary.cornerRadius
        recordButton.tintColor = theme.buttonPrimary.tintColor
        recordButton.setImage(UIImage(systemName: "waveform"), for: .normal)
        recordButton.setImage(UIImage(systemName: "stop.fill"), for: .selected)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        recognizer.stopRecording()
    }
    
    @IBAction func recordingState(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if (sender.isSelected) {
            recognizer.record { transcript in
                self.transcriptArea.text = transcript
            }
        } else {
            recognizer.stopRecording()
        }
    }
}

extension RecordingViewController: AVAudioPlayerDelegate {
    
}
