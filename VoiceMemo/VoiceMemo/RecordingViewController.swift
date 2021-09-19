//
//  RecordingViewController.swift
//  VoiceMemo
//
//  Created by John Hatvani on 16/9/21.
//

import Foundation
import UIKit

public class RecordingViewController: UIViewController {
    lazy var theme = getTheme()
    
    lazy var appDelegate: AppDelegate = {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("no app delegate")
        }
        return appdelegate
    }()
    
    var recording: Recording?
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var transcriptArea: UITextView!
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = theme.primaryBackground
        transcriptArea.textColor = theme.titleColor
        playPauseButton.backgroundColor = theme.buttonPrimary.backgroundColor
        playPauseButton.layer.cornerRadius = theme.buttonPrimary.cornerRadius
        playPauseButton.tintColor = theme.buttonPrimary.tintColor
       
        deleteButton.backgroundColor = theme.buttonPrimary.backgroundColor
        deleteButton.layer.cornerRadius = theme.buttonPrimary.cornerRadius
        deleteButton.tintColor = theme.buttonPrimary.tintColor
        
        guard let recording = recording else {
            navigationController?.popToRootViewController(animated: true)
            return
        }
        
        title = recording.datetime?.recordingListFormat()
        transcriptArea.text = recording.transcript
    }
    
    @IBAction func deleteRecord(_ sender: Any) {
        appDelegate.persistentContainer.viewContext.delete(recording!)
    }
    
}

