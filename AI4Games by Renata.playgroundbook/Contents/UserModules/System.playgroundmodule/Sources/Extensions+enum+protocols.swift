import UIKit

public enum StateMachineTypes {
    case hungry, lonely, normal, thirsty
}
public enum StateMachineConditions: Int {
    case lowFertilizer, lowLove, lowWater, everythingFine, none
}

extension StateMachineConditions: Comparable {
    public static func <(lhs: StateMachineConditions, rhs: StateMachineConditions) -> Bool { lhs.rawValue < rhs.rawValue }
}

public enum StateType: String {
    case normal = "Normal"
    case lonely = "Lonely"
    case thirsty = "Thirsty"
    case withered = "Withered"
    case hungry = "Hungry"
    case abandoned = "Abandoned"
    case desolated = "Desolated"
    case zombie = "Zombie"
    
    func getImage() -> UIImage {
        switch self {
        case .normal: return #imageLiteral(resourceName: "Normal.png")
        case .lonely: return #imageLiteral(resourceName: "Lonely.png")
        case .thirsty: return #imageLiteral(resourceName: "Thirsty.png")
        case .hungry: return #imageLiteral(resourceName: "Hungry.png")
        case .abandoned: return #imageLiteral(resourceName: "abandoned.png")
        case .desolated: return #imageLiteral(resourceName: "desolated.png")
        case .withered: return #imageLiteral(resourceName: "withered.png")
        case .zombie: return #imageLiteral(resourceName: "dead.png")
        default: return #imageLiteral(resourceName: "Normal.png")
        }
        
    }
}

public protocol GameTimerDelegate: class {
    func didEndGame()
}
public protocol GameActionDelegate: class {
    func did(action: String)
}
extension UIView {
    func fix(in otherView: UIView, to side: ConstraintType, with constant: CGFloat) -> NSLayoutConstraint {
        switch side {
        case .top:
            return self.topAnchor.constraint(equalTo: otherView.topAnchor, constant: constant)
        case .bottom:
            return self.bottomAnchor.constraint(equalTo: otherView.bottomAnchor, constant: constant)
        case .left:
            return self.leftAnchor.constraint(equalTo: otherView.leftAnchor, constant: constant)
        case .right:
            return self.rightAnchor.constraint(equalTo: otherView.rightAnchor, constant: constant)
        case .centerX:
            return self.centerXAnchor.constraint(equalTo: otherView.centerXAnchor, constant: constant)
        case .centerY:
            return self.centerYAnchor.constraint(equalTo: otherView.centerYAnchor, constant: constant)
        default: return NSLayoutConstraint()
        }
    }
}
public enum ConstraintType {
    case top, bottom, left, right, centerX, centerY
}

public enum GameModeType {
    case gameWithNoState, gameWithSimplesStates, gameWithDecisionTree, tutorial
}
