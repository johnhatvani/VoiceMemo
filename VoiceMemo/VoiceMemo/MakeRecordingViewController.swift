//
//  RecordingViewController.swift
//  VoiceMemo
//
//  Created by John Hatvani on 16/9/21.
//

import UIKit
import AVKit

public class MakeRecordingViewController: UIViewController {
    lazy var theme = getTheme()
    lazy var recognizer = SpeechRecognizer()

    lazy var appDelegate: AppDelegate = {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError("no app delegate") }
        return appdelegate
    }()
    
    lazy var recordingFileURL: URL = {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let recordingPath = paths[0].appendingPathComponent("\(NSUUID().uuidString).wav")
        return recordingPath
    }()
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var transcriptArea: UITextView!
    var recordingStart: Date?

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
            recordingStart = Date()
            try! recognizer.startRecording(saveTo: recordingFileURL) { string in
                self.transcriptArea.text = string
            }

        } else {
            recognizer.stopRecording()
            let record = Recording(context: appDelegate.persistentContainer.viewContext)
            record.transcript = transcriptArea.text
            record.datetime = Date()
            record.duration = Date().timeIntervalSince(recordingStart ?? Date())
            record.recordingURL = recordingFileURL
            
            appDelegate.persistentContainer.saveContext()
        }
    }
}

extension MakeRecordingViewController: AVAudioPlayerDelegate {
    
}
