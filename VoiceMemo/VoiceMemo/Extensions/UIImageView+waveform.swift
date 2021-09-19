//
//  WaveformImageView.swift
//  VoiceMemo
//
//  Created by John Hatvani on 19/9/21.
//

import Foundation
import UIKit
import DSWaveformImage

extension UIImageView {
    
    /// I dont know how expensive this is, it may be worth caching this image when it has been rendered once
    func generateWaveFile(fromURL asset: URL ) {
        let waveformImageDrawer = WaveformImageDrawer()
        let settings: Waveform.Configuration = .init(
            size: self.bounds.size,
            style: .striped(
                .init(color: getTheme().subtitleColor, width: 6, spacing: 2, lineCap: .round)
            ),
            position: .middle)
        
        waveformImageDrawer.waveformImage(fromAudioAt: asset, with: settings)  { image in
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
