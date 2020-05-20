
import UIKit

public class HUDView: UIView {
    public init(with frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView() {
        setupBackground()
        buildView()
        setupConstraints()
    }
    func setupBackground() {
        addSubview(backgroundView)
        configureBackgroundView()
    }
    var backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemBackground
        view.alpha = 0.9
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    func configureBackgroundView() {
        NSLayoutConstraint.activate([
            backgroundView.fix(in: self,to: .top, with: 0),
            backgroundView.fix(in: self, to: .bottom, with: 0),
            backgroundView.fix(in: self, to: .left, with: 0),
            backgroundView.fix(in: self, to: .right, with: 0)
        ])
    }
    func buildView() {}
    func setupConstraints() {}
    func configureAutomask() {
        self.subviews.forEach { view in 
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
