import UIKit

public class HUDActionView: HUDView {
    weak var delegate: GameActionDelegate?
    override func buildView() {
        self.isUserInteractionEnabled = true
        addSubview(fertilizerButton)
        addSubview(loveButton)
        addSubview(waterButton)
        addActions()
    }
    func addActions() {
        fertilizerButton.addTarget(self, action: #selector(clicked(_:)), for: .touchUpInside)
        loveButton.addTarget(self, action: #selector(clicked(_:)), for: .touchUpInside)
        waterButton.addTarget(self, action: #selector(clicked(_:)), for: .touchUpInside)
    }
    func lockButtons(isOff off: Bool) {
        fertilizerButton.isEnabled = off
        loveButton.isEnabled = off
        waterButton.isEnabled = off
    }
    @objc func clicked(_ sender: UIButton!) {
        switch sender.tag {
        case 1:
            delegate?.did(action: "Water") 
        case 2:
            delegate?.did(action: "Love") 
        case 3:
            delegate?.did(action: "Fertilizer") 
        default: break
        }
        lockButtons(isOff: false)
    }
    override func setupConstraints() {
        configureAutomask()
        configureSize(of: loveButton, sizeW: 85, sizeH: 75)
        configureSize(of: fertilizerButton, sizeW: 80, sizeH: 60)
        configureSize(of: waterButton, sizeW: 100, sizeH: 80)
        NSLayoutConstraint.activate([
            loveButton.fix(in: fertilizerButton, to: .right, with: -110),
            fertilizerButton.fix(in: self, to: .centerX, with: 0),
            waterButton.fix(in: fertilizerButton, to: .left, with: 110)
        ])
    }
    func configureSize(of button: UIView, sizeW: CGFloat, sizeH: CGFloat) {
        NSLayoutConstraint.activate([
            button.fix(in: self, to: .centerY, with: 0),
            button.heightAnchor.constraint(equalToConstant: sizeW),
            button.widthAnchor.constraint(equalToConstant: sizeH)
        ])
    }
    var fertilizerButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.tag = 3
        button.setImage(#imageLiteral(resourceName: "fertilizer.png"), for: .normal)
        return button
    }()
    var loveButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.tag = 2
        button.setImage(#imageLiteral(resourceName: "Coração.png"), for: .normal)
        return button
    }()
    var waterButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.tag = 1
        button.setImage(#imageLiteral(resourceName: "agua.png"), for: .normal)
        return button
    }()
}
