import UIKit

public class HUDLevelsView: HUDView {
    var gameTimer: Timer?
    var timePass: Float = 0.0
    func startTimer() {
        gameTimer?.invalidate()
        timePass = 10
        gameTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
            self?.timePass -= 1
                self?.timerView.progress = (self?.timePass ?? 0) / 10
        }
    }
    func updateTimerView() {
        self.timerView.progress = 1
        startTimer()
    }
    func updateProgressBar(water: Float, fertilizer: Float, love: Float) {
        UIView.animate(withDuration: 0.3) { 
            self.loveLevelProgressView.progress = love/10.0
            self.fertilizerLevelProgressView.progress = fertilizer/10.0
            self.waterLevelProgressView.progress = water/10.0
        }
    }
    var loveLevelLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Love"
        return label
    }()
    var loveLevelProgressView: UIProgressView = {
        let view = UIProgressView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.progressTintColor = .init(red: 235/255, green: 99/255, blue: 131/255, alpha: 1)
        return view
    }()
    var waterLevelLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Water"
        return label
    }()
    var waterLevelProgressView: UIProgressView = {
        let view = UIProgressView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.progressTintColor = .init(red: 134/255, green: 204/255, blue: 255/255, alpha: 1)
        return view
    }()
    var fertilizerLevelLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Fertilizer"
        return label
    }()
    var timerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Time left to update status: "
        return label
    }()
    var fertilizerLevelProgressView: UIProgressView = {
        let view = UIProgressView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.progressTintColor = .init(red: 3/255, green: 130/255, blue: 99/255, alpha: 1)
        return view
    }()
    var timerView: UIProgressView = {
        let view = UIProgressView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.progressTintColor = .label
        return view
    }()
    public func timerView(hidden: Bool) {
        timerView.isHidden = hidden
        timerLabel.isHidden = hidden
    }
    
    override func buildView() {
        addSubview(fertilizerLevelLabel)
        addSubview(fertilizerLevelProgressView)
        addSubview(loveLevelLabel)
        addSubview(loveLevelProgressView)
        addSubview(waterLevelLabel)
        addSubview(waterLevelProgressView)
        addSubview(timerLabel)
        addSubview(timerView)
    }
    override func setupConstraints() {
        configureAutomask()
        //love 
        configureFirstLabel()
        configure(view: loveLevelProgressView, with: loveLevelLabel)
        configureSize(of: loveLevelProgressView)
        //fertilizer 
        configure(view: fertilizerLevelLabel, with: loveLevelProgressView)
        configure(view: fertilizerLevelProgressView, with: fertilizerLevelLabel)
        configureSize(of: fertilizerLevelProgressView)
        //water
        configure(view: waterLevelLabel, with: fertilizerLevelProgressView)
        configure(view: waterLevelProgressView, with: waterLevelLabel)
        configureSize(of: waterLevelProgressView)
        //timer
        configure(view: timerLabel, with: waterLevelProgressView)
        configure(view: timerView, with: timerLabel)
        timerView.heightAnchor.constraint(equalToConstant: 20).isActive = true
}
    func configureFirstLabel() {
        NSLayoutConstraint.activate([
            loveLevelLabel.fix(in: self, to: .top, with: 20),
            loveLevelLabel.fix(in: self, to: .left, with: 20)
        ])
    }
    func configureSize(of view: UIView) {
        view.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }
    func configure(view: UIView, with topView: UIView) {
        NSLayoutConstraint.activate([
            view.fix(in: topView, to: .top, with: 30),
            view.fix(in: self, to: .left, with: 20),
            view.fix(in: self, to: .right, with: -20)
        ])
    }
}
