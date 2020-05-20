import AVFoundation
import UIKit

public class LastCutScene: CutSceneView {
    override func runAdditionalConfiguration() {
        self.textList = screenText
    }
    override func finishScene(){
        imageTimer?.invalidate()
        UIView.animate(withDuration: 0.4) {
            self.subtitleLabelView.isHidden = true
            self.subtitleBackgroundView.isHidden = true
        }
    }
    override func startTalk() {
        guard var text = textList?[currentText] else { return }
        speak(this: text)
        self.subtitleLabelView.text = text
        currentText+=1
    }
    var screenText = [
        "Wow! Now the game is amazing!", //0
        "With all these techniques we've added, we can even load our game on the App Store!", //1
        "Thank you so much for this fun, you're amazing!", //2
        "Hope to see you again!",
        "Bye!"
    ]
}
