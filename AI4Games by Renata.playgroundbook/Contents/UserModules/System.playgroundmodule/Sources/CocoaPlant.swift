//
//  Cocoa.swift
//  BookCore
//
//  Created by Renata Faria on 06/05/20.
//

import Foundation
import GameplayKit

final class CocoaPlant: GKStateMachine {
    public var gameMode: GameModeType = .gameWithNoState
    private var fertilizerLevel: Int = 10 {
        willSet {
            fertilizerLevel = min(10, fertilizerLevel)
            fertilizerLevel = max(0, fertilizerLevel)
        }
    }
    private var waterLevel: Int = 10{
        willSet {
            fertilizerLevel = min(10, fertilizerLevel)
            fertilizerLevel = max(0, fertilizerLevel)
        }
    }
    private var loveLevel: Int = 10 {
        willSet {
            fertilizerLevel = min(10, fertilizerLevel)
            fertilizerLevel = max(0, fertilizerLevel)
        }
    }
    private var fertilizerOld: Int = 10
    private var waterOld: Int = 10
    private var loveOld: Int = 10
    private var decisionTree = DecisionTree()
    private var plantCurrentState: StateType = .normal
    func updateDay() {
        fertilizerOld = fertilizerLevel
        loveOld = loveLevel
        waterOld = waterLevel
        takeCare(of: &fertilizerLevel)
        takeCare(of: &waterLevel)
        takeCare(of: &loveLevel)
        updateState()
    }
    func updateState() {
        if gameMode == .gameWithNoState {
            //do nothing, be normal 😆
        } else if gameMode == .gameWithDecisionTree{
            changeStateWithDecisionTree()
        } else {
            changeState()
        }
    }
    func changeStateWithDecisionTree() {
        if let newState = decisionTree.askNewState(fertilizer: fertilizerLevel, water: waterLevel, love: loveLevel) as? String {
            let newState = StateType.init(rawValue: newState)
            plantCurrentState = newState ?? .normal
            switch newState {
            case .abandoned:
                self.enter(Abandoned.self)
            case .normal:
                self.enter(Normal.self)
            case .lonely:
                self.enter(Lonely.self)
            case .thirsty:
                self.enter(Thirsty.self)
            case .withered:
                self.enter(Withered.self)
            case .hungry:
                self.enter(Hungry.self)
            case .desolated:
                self.enter(Desolated.self)
            case .zombie:
                self.enter(Zombie.self)
            default:
                self.enter(Normal.self)
            }
        }
    }
    func changeState() {
        if fertilizerLevel > 8 && waterLevel > 8 && loveLevel > 8 {
            plantCurrentState = .normal
            self.enter(Normal.self)
            return
        }
        if fertilizerLevel < waterLevel && fertilizerLevel < loveLevel {
            plantCurrentState = .hungry
            self.enter(Hungry.self)
        } else if loveLevel < waterLevel {
            plantCurrentState = .lonely
            self.enter(Lonely.self)
        } else {
            plantCurrentState = .thirsty
            self.enter(Thirsty.self)
        }
    }
    
    func get(necessity: String) -> Float {
        if necessity == "water" { return Float( self.waterLevel) }
        if necessity == "fertilizer" { return Float( self.fertilizerLevel) }
        if necessity == "love" { return Float( self.loveLevel) }
        return 0
    }
    func getOld(necessity: String) -> Float {
        if necessity == "water" { return Float( self.waterOld) }
        if necessity == "fertilizer" { return Float( self.fertilizerOld) }
        if necessity == "love" { return Float( self.loveOld) }
        return 0
    }
    
    public func getCurrentState() -> StateType {
        return plantCurrentState
    }
    
    func takeCare(of necessity: inout Int) {
        let random = Int.random(in: 0..<3)
        necessity -= random
    }
    func putWater() {
        waterOld+=2
        waterLevel+=2
    }
    func putFertilizer() {
        fertilizerOld+=2
        fertilizerLevel+=2
    }
    func giveLove() {
        loveOld+=2
        loveLevel+=2
    }
}
