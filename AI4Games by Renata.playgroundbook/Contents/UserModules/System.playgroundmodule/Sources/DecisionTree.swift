//
//  CocoaDecisionTree.swift
//  BookCore
//
//  Created by Renata Faria on 06/05/20.
//

import Foundation
import GameplayKit

class DecisionTree {
    private var decisionTree: GKDecisionTree!
    private let attributes = ["lowFertilizerLevel?", "lowWaterLevel?", "lowLoveLevel?"]
    private let examples = [
        [false, false, false],
        [false, false, true],
        [false, true, false],
        [false, true, true],
        [true, false, false],
        [true, true, false],
        [true, false, true],
        [true, true, true]
    ]
    private var actions =  ["Normal", "Lonely", "Thirsty", "Withered", "Hungry", "Abandoned", "Desolated", "Zombie"]
    
    
    init() {
        initDecisionTree()
    }
    
    func initDecisionTree() {
        decisionTree = GKDecisionTree(examples: examples as NSArray as! [[NSObjectProtocol]], actions: actions as NSArray as! [NSObjectProtocol], attributes: attributes as NSArray as! [NSObjectProtocol])
    }
    func askNewState(fertilizer: Int, water: Int, love: Int) -> NSObjectProtocol? {
        let answers = [
            "lowFertilizerLevel?": fertilizer < 6, // an enum value
            "lowWaterLevel?": water < 6,
            "lowLoveLevel?": love < 5
        ]
        let result = decisionTree.findAction(forAnswers: answers as [AnyHashable : NSObjectProtocol])
        return result
    }
}
