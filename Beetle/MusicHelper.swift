import AVFoundation

class MusicHelper {
    static let sharedHelper = MusicHelper()
    var audioPlayer: AVAudioPlayer?
    var playing = false;
    var song = "gno"
    func playBackgroundMusic() {
         let randomNum = Int(arc4random_uniform(UInt32(6)))
        print("random \(randomNum)")
        print("random \(randomNum % 2)")
        if randomNum < 3  {
            song = "Arabesque"
        }
        
        let aSound = URL(fileURLWithPath: Bundle.main.path(forResource: song, ofType: "mp3")!)
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
