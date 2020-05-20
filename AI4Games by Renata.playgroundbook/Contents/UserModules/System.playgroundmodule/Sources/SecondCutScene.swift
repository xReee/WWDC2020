
import AVFoundation
import UIKit

public class SecondCutScene: CutSceneView { 
    var isWrong = [String: Bool]()
    var stateCount = 0
    
    public func add(state: StateMachineTypes, withCondition condition: StateMachineConditions) {
        if !self.skipNext { return }
        switch state {
        case .hungry:
            isWrong["Hungry"] = condition == .lowFertilizer
        case .lonely:
            isWrong["Lonely"] = condition == .lowLove 
        case .thirsty:
            isWrong["Thirsty"] = condition == .lowWater 
        default:
            isWrong["Normal"] = condition == .everythingFine
        }
        nextText()
    }
    func nextText() {
        self.stateCount+=1
        if self.stateCount < 4 { 
            talkOnce(text: "Haven't you missed something?")
            return
        }
        let correct = isWrong.filter{ $0.value == true }
        if correct.count == 4 {
            talkOnce(text: "Nice! Everything correct, let's play")
            self.finishScene()
        } else {
            let incorrect = isWrong.filter{ $0.value == false }.keys
            let state = incorrect.count > 1 ? "states." : "state."
            talkOnce(text: "Please, fix the \(incorrect.joined(separator:" and the ")) \(state)")
        }
    }
    override func speakNext() {
        if !self.skipNext {
            self.textList = secondScreenText
            startTalk()
        }
    }
    func talkOnce(text: String) {
        speak(this: text)
        self.subtitleLabelView.text = text
        imageTimer?.invalidate()
    }
    override func startTalk() {
        guard var arr = textList else { return }
        guard arr.count > currentText else {
            imageTimer?.invalidate()
            return
        }
        let text = arr[currentText]
        speak(this: text)
        self.subtitleLabelView.text = text
        currentText+=1
    }
    var secondScreenText = [
        "Hey!! Hope you liked the game.", //0
        "Haven't you notice something weird?", //1
        "Even with all my necessities low, I continued to be happy... actually, in my \"normal state\".", //2
        "Wouldn't be better if, for example, when my Fertilizer level was low, I become \"Hungry\". Or my Water level low, I should change my status STATE, for \"Thirst\"?", //3
        "This is the concept of States, which is widely used in Video Games, to make the game look more realistic!", //4
        "How it works?", //5
        "First, we have some states, and some conditions. For example: if I have low fertilizer level. This condition makes me feel hungry.", //6
        "To switch states, we use something called 'State Machine'.",
        "We input the states we have, and also the conditions to activate each one of them.",
        "Knowing that, let's change this game! We need to add more states.",
        "In you left side, you see the code to change, I did the first one, can you complete the rest of it?",
        "Also, turn the variable skipTalk to true, in order to start to implement the state machine.",
        "When you finish, run the code again!",
        "I can't wait to see the changes!"
    ]
}
