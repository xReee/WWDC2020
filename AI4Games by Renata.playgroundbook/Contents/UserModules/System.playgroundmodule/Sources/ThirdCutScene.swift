

import AVFoundation
import UIKit

public class ThirdCutScene: CutSceneView {
    var isWrong = [String: Bool]()
    var stateCount = 0
    
    public func when(condition: StateMachineConditions, and anotherCondition: StateMachineConditions = .none, and finalCondition: StateMachineConditions = .none, changeStateFor state: StateType) {
        if !self.skipNext { return }
        let arrConditions = [condition, anotherCondition, finalCondition]
        switch state {
        case .lonely:
            isWrong["Lonely"] = check(conditions: arrConditions, for: [.lowLove, .none, .none])
        case .thirsty:
            isWrong["Thirsty"] = check(conditions: arrConditions, for: [.lowWater, .none, .none])
        case .hungry:
            isWrong["Hungry"] = check(conditions: arrConditions, for: [.lowFertilizer, .none, .none])
        case .withered:
            isWrong["Withered"] = check(conditions: arrConditions, for: [.lowWater, .lowLove, .none])
        case .abandoned:
            isWrong["Abandoned"] = check(conditions: arrConditions, for: [.lowWater, .lowFertilizer, .none])
        case .desolated:
            isWrong["Desolated"] = check(conditions: arrConditions, for: [.lowLove, .lowFertilizer, .none])
        case .zombie:
            isWrong["Zombie"] = check(conditions: arrConditions, for: [.lowLove, .lowFertilizer, .lowWater])
        default:
            isWrong["Normal"] = check(conditions: arrConditions, for: [.everythingFine, .none, .none])
        }
        nextText()
    }
    
    func check(conditions: [StateMachineConditions], for correctConditions: [StateMachineConditions]) -> Bool {
        var result = false
        result = conditions.sorted() == correctConditions.sorted()
        return result
    }
    
    func nextText() {
        self.stateCount+=1
        if self.stateCount < 4 {
            talkOnce(text: "Haven't you missed something?")
            return
        }
        let correct = isWrong.filter{ $0.value == true }
        if correct.count == 8 {
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
        "Wow! The game now is a lot more realistic, right ?", //0
        "Is it possible to improve even more the game? What do you think?", //1
        "If you said yes, then you're right!", //2
        "When I'm hungry, I can't be thirsty. Even when my fertilizer, and water level, are at the same level.",
        "Isn't it weird?", //3
        "That's because we check it out one by one and switched the states.",
        "So if Hungry is verified first, I will never know if I am thirsty too.", //4
        "How can we change the way to decide? But now, looking at every condition, before we change to the new state.", //5
        "Knowing this problem, the videogame industry, adopted an analytical technique, called \"Decision tree\".",
        "The Decision Tree, also known as \"Behaviour Tree\", works like this:",
        "We have several conditions. We verify it, and then, we check which ones are true.",
        "After it, we check what is the state, that have all the conditions, that we marked as true before.",
        "Is better to understand when we exemplify.",
        "Let's imagine that, two conditions are true in game.",
        "\"Water level is low.\" and \"Fertilizer level is low.\"",
        "Hungry state only applies when fertilizer level is low, but not when water is also low.",
        "Therefore, this state will not be activated.",
        "The same happen with the Thirsty state.",
        "We need a new state for this situation, right? The new one, that I invented, is called \"Abandoned\".",
        "I will also add other states:",
        "When lonely (low love), and when thirsty (low water), we should activate the \"Withered\".",
        "When lonely (low love), and hungry (low fertilizer), we should activate the \"Desolated\".",
        "When hungry (low fertilizer), thirsty (low water), and lonely (low love), we should activate the \"Zombie\".",
        "Let's modify the game again!",
        "Dont forget to change the \"skipTalk\" to true before start.",
        "When you finish, run the code again!",
        "I'm looking foward to see the changes!"
    ]
}
