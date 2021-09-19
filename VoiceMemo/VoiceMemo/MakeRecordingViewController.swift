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
    var willCloseModal: (() -> Void)?

    lazy var appDelegate: AppDelegate = {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError("no app delegate") }
        return appdelegate
    }()
    
    lazy var recordingFilename: String = {
        return "\(NSUUID().uuidString).wav"
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
        willCloseModal?()
    }
    
    @IBAction func recordingState(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if (sender.isSelected) {
            recordingStart = Date()
            let fileURL = getDocumentsURL().appendingPathComponent(recordingFilename)
            try! recognizer.startRecording(saveTo: fileURL) { string in
                self.transcriptArea.text = string
            }

        } else {
            recognizer.stopRecording()
            let _ = try! Recording.create(withContext: appDelegate.persistentContainer.viewContext,
                                          transcript: transcriptArea.text,
                                          filename: recordingFilename,
                                          duration: Date().timeIntervalSince(recordingStart ?? Date()))
                                          
            appDelegate.persistentContainer.saveContext()
            navigationController?.popViewController(animated: true)
        }
    }
}

extension MakeRecordingViewController: AVAudioPlayerDelegate {
    
}
