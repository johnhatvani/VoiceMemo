//
//  RecordingViewController.swift
//  VoiceMemo
//
//  Created by John Hatvani on 16/9/21.
//

import UIKit


public class RecordingViewController: UIViewController {
    lazy var theme = getTheme();
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var transcriptArea: UITextView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = theme.primaryBackground
        transcriptArea.textColor = theme.titleColor
        recordButton.backgroundColor = theme.buttonPrimary.backgroundColor
        recordButton.layer.cornerRadius = theme.buttonPrimary.cornerRadius
        recordButton.tintColor = theme.buttonPrimary.tintColor
    }
}
