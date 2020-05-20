import UIKit
import PlaygroundSupport

public class HUDEndGame: HUDView {
    override func buildView() {
        addSubview(titleLabel)
        addSubview(nextButton)
    }
    override func setupConstraints() {
        configureAutomask()
        NSLayoutConstraint.activate([
            titleLabel.fix(in: self,to: .top, with: 20),
            titleLabel.fix(in: self, to: .centerX, with: 0),
            nextButton.fix(in: titleLabel, to: .top, with: 45),
            nextButton.fix(in: self, to: .right, with: -25),
            nextButton.fix(in: self, to: .left, with: 25),
            nextButton.fix(in: self, to: .bottom, with: -25),
        ])
        nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
    }
    @objc func nextPage() {
        PlaygroundPage.current.navigateTo(page: .next)
    }
    public func setText(_ text: String) {
        titleLabel.text = text
    }
    var nextButton: UIButton = {
        let view = UIButton(frame: .zero)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .black, scale: .large)
        let img = UIImage.init(systemName: "chevron.right.2", withConfiguration: imageConfig)
        view.setImage(img, for: .normal)
        view.tintColor = .label
        return view
    }()
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 20)
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Time's up!\n Let's go to next page."
        return label
    }()
}
