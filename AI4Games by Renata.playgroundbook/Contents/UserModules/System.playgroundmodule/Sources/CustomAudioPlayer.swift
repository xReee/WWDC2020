import AVFoundation
import PlaygroundSupport

@objc(Book_Sources_CustomAudioPlayer)
public class CustomAudioPlayer: AVAudioPlayer {
    
    static var audioPlayer: AVAudioPlayer?
    
    public func play(_ name: String, format: String, volume: Float, numberOfLoops: Int) {
        guard let url = Bundle.main.url(forResource: name, withExtension: format) else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient , mode: .default, options: [.duckOthers])
            try AVAudioSession.sharedInstance().setActive(true)
            
            CustomAudioPlayer.audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            
            guard let player = CustomAudioPlayer.audioPlayer else { return }
            player.volume = volume
            player.numberOfLoops = numberOfLoops
            player.prepareToPlay()
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    public func pauseAudio() {
        CustomAudioPlayer.audioPlayer?.pause()
    }
}
