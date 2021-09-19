//
//  RecordingViewController.swift
//  VoiceMemo
//
//  Created by John Hatvani on 16/9/21.
//

import UIKit
import AVKit


///
//let rec = Recording(context: appDelegate.persistentContainer.viewContext)
//rec.datetime = Date()
//rec.duration = 40
//rec.transcript = "the quick brown fox"

//appDelegate.persistentContainer.saveContext()


public class MakeRecordingViewController: UIViewController {
    lazy var theme = getTheme()
    lazy var recognizer = SpeechRecognizer()
    lazy var appDelegate: AppDelegate = {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("no app delegate")
        }
        return appdelegate
    }()
    
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
            
            let record = Recording(context: appDelegate.persistentContainer.viewContext)
            record.datetime = Date()
            record.transcript = transcriptArea.text
            record.duration = 30
            appDelegate.persistentContainer.saveContext()
        }
    }
}

extension MakeRecordingViewController: AVAudioPlayerDelegate {
    
}
