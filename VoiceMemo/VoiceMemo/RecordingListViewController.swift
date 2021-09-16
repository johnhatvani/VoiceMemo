//
//  ViewController.swift
//  VoiceMemo
//
//  Created by John Hatvani on 14/9/21.
//

import UIKit
import CoreGraphics

class RecordingListViewController: UIViewController {
    lazy var theme: Themeable = getTheme()
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your Recordings"
        view.backgroundColor = theme.primaryBackground
        
        recordingsTable.delegate = self
        recordingsTable.dataSource = self
        recordingsTable.rowHeight = UITableView.automaticDimension;
        recordingsTable.register(UINib(nibName: "RecordingCell", bundle: nil), forCellReuseIdentifier: "recording")

        recordButton.setImage(UIImage(systemName: "mic.fill"), for: .normal)
        recordButton.backgroundColor = theme.buttonPrimary.backgroundColor
        recordButton.tintColor = theme.buttonPrimary.tintColor
        recordButton.layer.cornerRadius = theme.buttonPrimary.cornerRadius
    }
}


extension RecordingListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
//        let record = getRecording(atIndexPath: indexPath)
        
    }
}

extension RecordingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getRecordingsLength()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recording: Recordable = getRecording(atIndexPath: indexPath) else {
            fatalError("no data")
        }
        print(recording)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recording") as? (UITableViewCell & MemoTableCell) else {
            fatalError("no cell")
        }
        
        cell.configure(withRecord: recording)
        cell.selectionStyle = .none
        return cell
    }

}

