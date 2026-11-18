import Foundation
import Speech
import AVFoundation
import Observation

// أداة تحوّل الصوت لنص
@Observable
class SpeechRecognizer {
    var transcript = ""       // الكلام بعد ما صار نص
    var isRecording = false   // المايك شغّال؟
    
    private let audioEngine = AVAudioEngine()
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    
    // ١. نطلب الإذن من المستخدم
    func requestPermission() async -> Bool {
        let speechAllowed = await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { @Sendable status in
                continuation.resume(returning: status == .authorized)
            }
        }
        let micAllowed = await AVAudioApplication.requestRecordPermission()
        return speechAllowed && micAllowed
    }
    
    // ٢. نبدأ نسمع
    func start() {
        transcript = ""
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        self.request = request
        
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.record, mode: .measurement, options: .duckOthers)
            try session.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            return
        }
        
        let input = audioEngine.inputNode
        let format = input.outputFormat(forBus: 0)
        input.installTap(onBus: 0, bufferSize: 1024, format: format) { @Sendable buffer, _ in
            request.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return
        }
        isRecording = true
        
        task = SFSpeechRecognizer(locale: Locale(identifier: "ar-SA"))?.recognitionTask(with: request) { @Sendable [weak self] result, error in
            let text = result?.bestTranscription.formattedString
            let isFinal = result?.isFinal ?? false
            Task { @MainActor in
                if let text {
                    self?.transcript = text
                }
                if error != nil || isFinal {
                    self?.stop()
                }
            }
        }
    }
    
    // ٣. نوقف
    func stop() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        request?.endAudio()
        task?.cancel()
        request = nil
        task = nil
        isRecording = false
    }
}
