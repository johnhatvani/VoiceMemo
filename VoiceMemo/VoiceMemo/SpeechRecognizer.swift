//
//  SpeechRecognizer.swift
//  VoiceMemo
//
//  Created by John Hatvani on 19/9/21.
//

import Foundation
import AVFoundation
import AVFAudio
import Speech
import SwiftUI

public struct SpeechRecognizer {
    private let assistant = SpeechAssist()
    
    func record(handler: @escaping (String) -> Void) {
        
        assistant.engine = AVAudioEngine()
        assistant.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        assistant.recognitionRequest?.shouldReportPartialResults = true

        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            
            let input = assistant.engine?.inputNode
            let format = AVAudioFormat(standardFormatWithSampleRate:48000, channels: 1)
            
            
            input?.installTap(onBus: 0, bufferSize: 1024, format: format) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
                assistant.recognitionRequest?.append(buffer)
            }
            
            assistant.engine?.prepare()
            try assistant.engine?.start()
            
            assistant.recognitionTask = assistant.recognizer?.recognitionTask(with: assistant.recognitionRequest!) { (result, error) in
                var isFinal = false
                if let result = result {
                    print(result.bestTranscription.formattedString)
                    handler(result.bestTranscription.formattedString);
                    isFinal = result.isFinal
                }
                print(isFinal)
                if error != nil || isFinal {
                    assistant.engine?.stop()
                    input?.removeTap(onBus: 0)
                    self.assistant.recognitionRequest = nil
                }
            }
        
        } catch {
            print("Error transcibing audio: " + error.localizedDescription)
            assistant.reset()
        }
    }

    func stopRecording() {
        assistant.reset()
    }
    
    func requestSpeechRecogniserPermission(handler: @escaping (Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { status in
            handler((status == .authorized))
        }
    }
    
    func requestMicrophonePermission(handler: @escaping (Bool) -> Void) {
        AVAudioSession.sharedInstance().requestRecordPermission(handler)
    }
}

fileprivate class SpeechAssist {
    var engine: AVAudioEngine?
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    var audioFile: AVAudioFile?
    let recognizer = SFSpeechRecognizer()

    
    deinit {
        reset()
    }
    
    func reset() {
        recognitionTask?.cancel()
        engine?.stop()
    }
}
