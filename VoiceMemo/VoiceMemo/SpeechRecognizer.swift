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
    
    func startRecording(saveTo filepath: URL, handler: @escaping (String) -> Void) throws {
        // Cancel the previous task if it's running.
        assistant.recognitionTask?.cancel()
        assistant.recognitionTask = nil
        
        assistant.engine = AVAudioEngine()
        guard let engine = assistant.engine else { fatalError("Unable to create AVAudioEngine") }
        
        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        try audioSession.setInputGain(0.7)
        let inputNode = engine.inputNode

        assistant.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = assistant.recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest") }
        recognitionRequest.shouldReportPartialResults = true
        
        assistant.recognitionTask = assistant.recognizer!.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            if let result = result {
                isFinal = result.isFinal
                handler(result.bestTranscription.formattedString)
                print("Text \(result.bestTranscription.formattedString)")
            }
            
            if error != nil || isFinal {
                inputNode.removeTap(onBus: 0)
                assistant.reset()
            }
        }
        
        guard let commonFormat = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: inputNode.inputFormat(forBus: 0).sampleRate, channels: 1, interleaved: true) else { return }
        let audioFile = try! AVAudioFile(forWriting: filepath, settings: commonFormat.settings, commonFormat: commonFormat.commonFormat, interleaved: true)
        
        // Configure the microphone input.
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: commonFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            assistant.recognitionRequest?.append(buffer)
            do {
                try audioFile.write(from: buffer)
            } catch {
                print(error.localizedDescription)
            }
        }
        engine.prepare()
        try engine.start()
    }
    
    func stopRecording() {
        assistant.reset()
    }
}

public class SpeechAssist: NSObject {
    var engine: AVAudioEngine?
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let recognizer = SFSpeechRecognizer()
        
    deinit {
        reset()
    }
    
    func reset() {
        recognitionTask?.cancel()
        engine?.stop()
        
        recognitionRequest = nil
        recognitionTask = nil
    }
}
