//
//  ViewController.swift
//  VoiceMemo
//
//  Created by John Hatvani on 14/9/21.
//

import UIKit
import CoreGraphics
import CoreData

class RecordingListViewController: UIViewController {
    lazy var theme: Themeable = getTheme()
    
    lazy var appDelegate: AppDelegate = {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("no app delegate")
        }
        return appdelegate
    }()
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingsTable: UITableView!
    
    var recordings = [Recording]()
    var selectedRecording: Recording?
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadRecords()
        recordingsTable.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recording" {
            (segue.destination as! RecordingViewController).recording = selectedRecording
        }
    }
}
extension RecordingListViewController {
    func loadRecords() {
        let sort = NSSortDescriptor(key: "datetime", ascending: false)
        let request = Recording.createFetchRequest(withSortDescriptors: [sort])
        
        do {
            recordings = try appDelegate.persistentContainer.viewContext.fetch(request)
            print("worked, \(recordings.count) recordings")
        } catch {
            print ("something died")
        }
    }
}


extension RecordingListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        selectedRecording = recordings[indexPath.row]
        performSegue(withIdentifier: "recording", sender: self)
    }
}

extension RecordingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recording") as? RecordingCell else {
            fatalError("no cell")
        }
        
        let recording = recordings[indexPath.row]
        
        cell.configure(withRecord: recording)
        cell.selectionStyle = .none
        return cell
    }
}

