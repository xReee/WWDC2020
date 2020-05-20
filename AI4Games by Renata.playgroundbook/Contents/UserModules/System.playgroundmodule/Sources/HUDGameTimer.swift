
import UIKit

public class HUDGameTimer: HUDView {
    var gameTimer: Timer?
    let shapeLayer = CAShapeLayer()
    public weak var gameDelegate: GameTimerDelegate?

    @objc func hourPass() {
        UIView.animate(withDuration: 0.1, animations: {
            self.shapeLayer.strokeEnd -= 1/30
        })
        let newValue = Int(self.shapeLayer.strokeEnd * 30)
        timerNumberLabel.text = "\(newValue)"
        if newValue < 1 {
            self.gameTimer?.invalidate()
            gameDelegate?.didEndGame()
        }
    }
    override func buildView() {
        addSubview(timerLabel)
        addSubview(timerView)
        addSubview(timerNumberLabel)
    }
    override func setupConstraints() {
        configureAutomask()
        NSLayoutConstraint.activate([
            timerLabel.fix(in: self,to: .top, with: 5),
            timerLabel.fix(in: self, to: .centerX, with: 0),
            timerView.fix(in: timerLabel, to: .top, with: 25),
            timerView.fix(in: self, to: .right, with: -15),
            timerView.fix(in: self, to: .left, with: 15),
            timerView.fix(in: self, to: .bottom, with: -10),
            timerNumberLabel.fix(in: timerView, to: .centerX, with: 0),
            timerNumberLabel.fix(in: timerView, to: .centerY, with: 0)
        ])
        addTimerLayer()
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(hourPass), userInfo: nil, repeats: true)
    }
    
    func addTimerLayer() {
        let bezierPath = UIBezierPath(arcCenter: .zero, radius: 25, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.label.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.strokeEnd = 1.0
        let viewTeste = UIView(frame: CGRect(x: 0, y: 0, width: timerView.frame.width, height: timerView.frame.height))
        viewTeste.translatesAutoresizingMaskIntoConstraints = false
        viewTeste.layer.addSublayer(shapeLayer)
        
        timerView.addSubview(viewTeste)
        viewTeste.centerXAnchor.constraint(equalTo: self.timerView.centerXAnchor).isActive = true
        viewTeste.centerYAnchor.constraint(equalTo: self.timerView.centerYAnchor).isActive = true
    }
    var timerView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    var timerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .label
        label.textAlignment = .center
        label.text = "End time:"
        return label
    }()
    var timerNumberLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .label
        label.textAlignment = .center
        label.text = "30"
        return label
    }()
    
}
