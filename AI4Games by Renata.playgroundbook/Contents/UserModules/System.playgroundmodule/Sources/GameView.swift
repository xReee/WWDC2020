import UIKit
import AVFoundation
import PlaygroundSupport

public class GameView: UIView {
    var cocoaTree: CocoaPlant!
    var gameTimer: Timer?
    
    public init(with frame: CGRect, gameMode: GameModeType) {
        super.init(frame: frame)
        self.playMusic()
        self.setupView()
        switch gameMode {
        case .tutorial:
            break
        case .gameWithNoState, .gameWithDecisionTree, .gameWithSimplesStates:
            self.initStateMachine(with: gameMode)
        default: break
        }
        
    }
    deinit { gameTimer?.invalidate() }
    func playMusic() {
        let player = CustomAudioPlayer()
        player.play("backmusic", format: "m4a", volume: 0.4, numberOfLoops: -1)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initStateMachine(with gameMode: GameModeType) {
        cocoaTree = CocoaPlant(states: [Normal(), Thirsty(), Lonely(), Hungry(), Zombie(), Abandoned(), Desolated(), Withered()])
        self.cocoaTree.enter(Normal.self)
        self.cocoaTree.gameMode = gameMode
        gameTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(hourPass), userInfo: nil, repeats: true)
        hudActionView.delegate = self
        hudGameTimer.gameDelegate = self
    }
    @objc func hourPass() {
        changeStateImage(to: cocoaTree.getCurrentState())
        changeNecessitiesProgressBar(isNewDay: true)
        self.hudLevelsView.updateTimerView()
        cocoaTree.updateDay()
        hudActionView.lockButtons(isOff: true)
    }
    func pauseGame() {
        gameTimer?.invalidate()
        self.hideViews()
        addSubview(hudEndGame)
        setupConstraintsEndView()
    }
    func hideViews() {
        self.subviews.forEach { [weak self] view in
            if view != self?.backgroundImage {
                view.isHidden = true
            }
        } 
    }
    func changeNecessitiesProgressBar(isNewDay: Bool) {
        if isNewDay {
            self.hudLevelsView.updateProgressBar(water: self.cocoaTree.get(necessity: "water"),
                                                 fertilizer: self.cocoaTree.get(necessity: "fertilizer"),
                                                 love: self.cocoaTree.get(necessity: "love"))
        } else {
            self.hudLevelsView.updateProgressBar(water: self.cocoaTree.getOld(necessity: "water"),
                                                 fertilizer: self.cocoaTree.getOld(necessity: "fertilizer"),
                                                 love: self.cocoaTree.getOld(necessity: "love"))
        }
    }
    func changeStateImage(to state: StateType) {
        let newImage = state.getImage()
        self.stateLabel.text = state.rawValue
        self.plantImage.image = newImage
        self.plantImage.alpha = 0.9
        UIView.animate(withDuration: 0.2) {
            self.plantImage.alpha = 1
        }
    }
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "cenario.png"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    var plantImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Normal.png"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    lazy var stateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        let bgColor = UIColor.systemBackground
        label.backgroundColor = bgColor.withAlphaComponent(0.8)
        label.clipsToBounds = true
        label.textColor = .label
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var hudGameTimer: HUDGameTimer = {
        let view = HUDGameTimer(with: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
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
    lazy var hudEndGame: HUDEndGame = {
        let view = HUDEndGame(with: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    func buildView(){
        addSubview(backgroundImage)
        addSubview(plantImage)
        addSubview(stateLabel)
        addSubview(hudLevelsView)
        addSubview(hudActionView)
        addSubview(hudGameTimer)
    }
    func setupConstraints(){
        self.addConstraintToSuperView(view: backgroundImage, top: 0, left: 0, bottom: 0, right: 0)
        self.addConstraintToSuperView(view: plantImage, top: 100, left: 100, bottom: -200, right: -100)
        labelConstraints()
        hudLevelsConstraint()
        hudActionConstraint()
        hudGameTimerConstraint()
    }
    func setupConstraintsEndView() {
        NSLayoutConstraint.activate([
            hudEndGame.fix(in: backgroundImage, to: .centerX, with: 0),
            hudEndGame.fix(in: backgroundImage, to: .centerY, with: 0),
            hudEndGame.widthAnchor.constraint(equalToConstant: 250),
            hudEndGame.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    func hudGameTimerConstraint() {
        hudGameTimer.widthAnchor.constraint(equalToConstant: 100).isActive = true
        hudGameTimer.heightAnchor.constraint(equalToConstant: 100).isActive = true
        hudGameTimer.fix(in: hudActionView, to: .top, with: -10).isActive = true
        hudGameTimer.fix(in: self, to: .left, with: 10).isActive = true
    }
    func hudActionConstraint() {
        hudActionView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        hudActionView.heightAnchor.constraint(equalToConstant: 115).isActive = true
        hudActionView.fix(in: self, to: .top, with: 100).isActive = true
        hudActionView.fix(in: self, to: .right, with: -5).isActive = true
    }
    func  hudLevelsConstraint() {
        hudLevelsView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        hudLevelsView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        hudLevelsView.fix(in: self, to: .centerY, with: 0).isActive = true
        hudLevelsView.fix(in: self, to: .left, with: 10).isActive = true
    }
    func labelConstraints() {
        stateLabel.widthAnchor.constraint(equalToConstant: 280).isActive = true
        stateLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        stateLabel.topAnchor.constraint(equalTo: self.plantImage.bottomAnchor, constant: 25).isActive = true
        stateLabel.fix(in: self.plantImage, to: .centerX, with: 0).isActive = true
    }
    func addConstraintToSuperView(view: UIView, top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.fix(in: self,to: .top, with: top),
            view.fix(in: self, to: .bottom, with: bottom),
            view.fix(in: self, to: .left, with: left),
            view.fix(in: self, to: .right, with: right)
        ])
    }
    func setupView() {
        buildView()
        setupConstraints()
    }
}
extension GameView: GameActionDelegate {
    public func did(action: String) {
        switch action {
        case "Water":
            cocoaTree.putWater()
        case "Love":
            cocoaTree.giveLove()
        case "Fertilizer":
            cocoaTree.putFertilizer()
        default: break
        }
        changeNecessitiesProgressBar(isNewDay: false)
    }

    
}
extension GameView: GameTimerDelegate {
    public func didEndGame() {
        UIView.animate(withDuration: 0.5) { 
            self.pauseGame()
        }
    }
}
