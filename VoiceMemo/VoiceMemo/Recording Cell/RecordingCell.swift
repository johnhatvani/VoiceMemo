//
//  RecordingCell.swift
//  VoiceMemo
//
//  Created by John Hatvani on 14/9/21.
//

import UIKit
import CoreGraphics
import DSWaveformImage

class RecordingCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var waveform: UIImageView!
    
    let waveformImageDrawer = WaveformImageDrawer()
    lazy var theme = getTheme()
    
    func configure(withRecord record: Recording) {
        timeLabel.text = record.duration.formattedTime()
        dateLabel.text = record.datetime!.recordingListFormat()
        
        let url = getDocumentsURL().appendingPathComponent(record.filename!)
        waveform.generateWaveFile(fromURL: url)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let theme = getTheme()
        
        playButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)

        dateLabel.textColor = theme.titleColor
        dateLabel.backgroundColor = UIColor.clear
        
        timeLabel.textColor = theme.subtitleColor
        timeLabel.backgroundColor = UIColor.clear
        
        detailView.backgroundColor = theme.cellBackground
        detailView.layer.cornerRadius = 26
        
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
    }
}

class RecordingCellPlayback: UIView { }
