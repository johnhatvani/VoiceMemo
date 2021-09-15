//
//  ViewController.swift
//  VoiceMemo
//
//  Created by John Hatvani on 14/9/21.
//

import UIKit
import CoreGraphics

class RecordingListViewController: UIViewController {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordingsTable.delegate = self
        recordingsTable.dataSource = self
        recordingsTable.register(UINib(nibName: "RecordingCell", bundle: nil), forCellReuseIdentifier: "recording")
        
        recordingsTable.rowHeight = UITableView.automaticDimension;
//        recordingsTable.estimatedRowHeight = 110.0
        
        view.backgroundColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.00)
        title = "Your Recordings"
        
        recordButton.setImage(UIImage(systemName: "mic.fill"), for: .normal)
        recordButton.backgroundColor = UIColor(red: 1.00, green: 0.53, blue: 0.09, alpha: 1.00)
        recordButton.tintColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.00)
        recordButton.layer.cornerRadius = 31
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

