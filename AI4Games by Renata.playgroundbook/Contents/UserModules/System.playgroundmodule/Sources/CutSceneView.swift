import PlaygroundSupport
import AVFoundation
import UIKit

public class CutSceneView: UIView {
    public var personName = ""
    var voiceSynth: AVSpeechSynthesizer!
    var currentText = 0
    var textList: [String]?
    var skipNext = false
    let plantImages = [#imageLiteral(resourceName: "Normal-2.png"), #imageLiteral(resourceName: "Normal.png"), #imageLiteral(resourceName: "Normal-2.png"), #imageLiteral(resourceName: "Normal.png"), #imageLiteral(resourceName: "Normal-2.png"), #imageLiteral(resourceName: "Normal-3.png")]
    var currentImage = 0
    var imageTimer: Timer?
    
    public init( _ skipNext: Bool = false, name: String="") {
        super.init(frame: .zero)
        self.setupView()
        self.personName = name
        self.voiceSynth = AVSpeechSynthesizer()
        self.voiceSynth.delegate = self
        self.skipNext = skipNext
        self.playMusic()
        imageTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(changePlantImage), userInfo: nil, repeats: true)
        runAdditionalConfiguration()
        speakNext()
    }
    
    @objc func changePlantImage() {
        let count = plantImages.count-1
        currentImage += currentImage == count ? (count * -1) : 1
        plantImage.image = plantImages[currentImage]
    }
    func playMusic() {
        let player = CustomAudioPlayer()
        player.play("backmusic", format: "m4a", volume: 0.2, numberOfLoops: -1)
        voiceSynth.continueSpeaking()
    }
    func runAdditionalConfiguration() {}
    func speakNext() {
        guard textList?.count ?? 0 > currentText else {
            UIView.animate(withDuration: 0.5) {
                self.finishScene()
            }
            return
        }
        if !self.skipNext {
            startTalk()
        } else {
            self.subtitleBackgroundView.isHidden = true
            self.finishScene()
        }
    }
    func finishScene() {
        hudEndGame.setText("Let's play!")
        addSubview(hudEndGame)
        setupConstraintsEndView()
        imageTimer?.invalidate()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func buildView() {
        addSubview(backgroundImage)
        addSubview(plantImage)
        addSubview(subtitleBackgroundView)
        addSubview(subtitleLabelView)
    }
    func setupConstraints() {
        configureAutomask()
        self.addConstraint(view: backgroundImage, superview: self, top: 0, left: 0, bottom: 0, right: 0)
        NSLayoutConstraint.activate([
            plantImage.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            plantImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            plantImage.fix(in: self, to: .centerX, with: 0),
            plantImage.fix(in: self, to: .centerY, with: 0),
            subtitleBackgroundView.fix(in: self, to: .bottom, with: -100),
            subtitleBackgroundView.fix(in: self, to: .left, with: 10),
            subtitleBackgroundView.fix(in: self, to: .right, with: -10)
        ])
        self.addConstraint(view: subtitleLabelView, superview: subtitleBackgroundView, top: 10, left: 20, bottom: -10, right: -20)
    }
    func setupView() {
        buildView()
        setupConstraints()
        startTalk()
    }
    func startTalk() {}
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "cenario.png"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    lazy var subtitleBackgroundView: HUDView = {
        let view = HUDView(with: .zero)
        return view
    }()
    lazy var subtitleLabelView: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    lazy var plantImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Normal.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    lazy var hudEndGame: HUDEndGame = {
        let view = HUDEndGame(with: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    func configureAutomask() {
        self.subviews.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    func addConstraint(view: UIView, superview: UIView, top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.fix(in: superview,to: .top, with: top),
            view.fix(in: superview, to: .bottom, with: bottom),
            view.fix(in: superview, to: .left, with: left),
            view.fix(in: superview, to: .right, with: right)
        ])
    }
    func setupConstraintsEndView() {
        NSLayoutConstraint.activate([
            hudEndGame.fix(in: backgroundImage, to: .centerX, with: 0),
            hudEndGame.fix(in: backgroundImage, to: .centerY, with: 0),
            hudEndGame.widthAnchor.constraint(equalToConstant: 250),
            hudEndGame.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}
extension CutSceneView: AVSpeechSynthesizerDelegate {
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        plantImage.image = plantImages[0]
        currentImage = 0
        speakNext()
    }
    public func speak(this text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice.speechVoices().filter({ $0.name == "Samantha" }).first
        utterance.preUtteranceDelay = 1
        utterance.rate = 0.4
        voiceSynth.stopSpeaking(at: .immediate)
        voiceSynth.speak(utterance)
    }
}
