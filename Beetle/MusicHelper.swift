import AVFoundation

class MusicHelper {
    static let sharedHelper = MusicHelper()
    var audioPlayer: AVAudioPlayer?
    var playing = false;
    
    func playBackgroundMusic() {
        let aSound = URL(fileURLWithPath: Bundle.main.path(forResource: "gno", ofType: "mp3")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:aSound)
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
            playing = true
        } catch {
            print("Cannot play the file")
        }
    }
    
    func stopBackgroundMusic() {
        audioPlayer!.stop()
        playing = false
    }
}
