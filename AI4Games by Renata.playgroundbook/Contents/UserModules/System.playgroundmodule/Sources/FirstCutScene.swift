
import AVFoundation
import UIKit

public class FirstCutScene: CutSceneView {
    lazy var hudLevelsView: HUDLevelsView = {
        let view = HUDLevelsView(with: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var hudActionView: HUDActionView = {
        let view = HUDActionView(with: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var hudGameTimer: HUDGameTimer = {
        let view = HUDGameTimer(with: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func runAdditionalConfiguration() {
        self.textList = firstScreenText
    }
    func hudConstraint(_ menu: HUDView) {
        if menu is HUDLevelsView {
            hudLevelsConstraint()
        } else if menu is HUDActionView {
            hudActionConstraint()
        } else {
            hudGameTimerConstraint()
        }
    }
    func menu(this menu: HUDView, isHidden: Bool) {
        if menu is HUDLevelsView {
            hudLevelsView.timerView(hidden: true)
        }
        if !isHidden {
            menu.alpha = 0
            addSubview(menu)
            hudConstraint(menu)
        }
        UIView.animate(withDuration: 0.5, animations: {
            menu.alpha = isHidden ? 0 : 1
        })
    }
    func animateProgressBar(number: Int) {
        if number == 6 {
            self.hudLevelsView.updateProgressBar(water: 0, fertilizer: 0, love: 10)
        } else {
            self.hudLevelsView.updateProgressBar(water: 0, fertilizer: 5, love: 10)
        }
        
    }
    func  animateTimeBar() {
        UIView.animate(withDuration: 0.5) {
            self.hudLevelsView.timerView(hidden: false)
        }
        self.hudLevelsView.updateTimerView()
    }
    func  hudLevelsConstraint() {
        hudLevelsView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        hudLevelsView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        hudLevelsView.fix(in: self, to: .centerY, with: 0).isActive = true
        hudLevelsView.fix(in: self, to: .left, with: 10).isActive = true
    }
    func  hudActionConstraint() {
        hudActionView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        hudActionView.heightAnchor.constraint(equalToConstant: 115).isActive = true
        hudActionView.fix(in: self, to: .top, with: 100).isActive = true
        hudActionView.fix(in: self, to: .right, with: -5).isActive = true
    }
    func hudGameTimerConstraint() {
        hudGameTimer.widthAnchor.constraint(equalToConstant: 100).isActive = true
        hudGameTimer.heightAnchor.constraint(equalToConstant: 100).isActive = true
        hudGameTimer.fix(in: self, to: .top, with: 100).isActive = true
        hudGameTimer.fix(in: self, to: .left, with: 10).isActive = true
    }
    override func startTalk() {
        guard var text = textList?[currentText] else { return }
        switch currentText {
        case 0:
            text = "Hello \(personName), my name is Cocoa, I am a Cocoa Plant in growing process!"
        case 5:
            menu(this: hudLevelsView, isHidden: false)
        case 6,7:
            animateProgressBar(number: currentText)
        case 10:
            animateTimeBar()
        case 11:
            menu(this: hudLevelsView, isHidden: true)
            menu(this: hudActionView, isHidden: false)
        case 12:
            menu(this: hudActionView, isHidden: true)
            menu(this: hudGameTimer, isHidden: false)
        case 14:
            menu(this: hudGameTimer, isHidden: true)
        default: break
        }
        speak(this: text)
        self.subtitleLabelView.text = text
        currentText+=1
    }
    var firstScreenText = [
        "Hello! My name is Cocoa, I am a Cocoa Plant in growing process!", //0
        "My mom, Renata, is busy working in her playground code, for the Swift Student Challenge.",//1
        "How I cannot take care of myself alone, she said you would help me.", //2
        "As reward, I will teach you a little bit of AI for Games, do we agree?", //3
        "It's simple to take care of me, don't worry!", //4
        "First: this is the Menu you can check my necessities.", //5
        "When this bar is full, I'm okay!", //6
        "When it's in the middle, maybe you should pay attention to this necessity.", //7
        "If the bar is totally gray, oh no! Don't let me die...", //8
        "Well.. don't worry, you have 2 seconds in every update.", // 9
        "This bar will help you to know when the update will happen.", //10
        "To help me, you can click in these buttons, but careful! It's just once per turn.", //11
        "The last thing you need to know, is the whole game lasts 30 seconds.", //12
        "There is a clock in the top of the screen with the time left.", //13
        "That's all! Let's start?" //14
        ]
}
