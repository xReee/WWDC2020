//
//  Abandoned.swift
//  BookCore
//
//  Created by Renata Faria on 06/05/20.
//

import Foundation
import GameplayKit

// Representative class of all states
class PlantState: GKState {}

// All necessities are good
class Normal: PlantState {}

// All necessities are bad
class Zombie: PlantState {}

// Love is low
class Lonely: PlantState {}

// Fertilizer is low
class Hungry: PlantState {}

// Water is low
class Thirsty: PlantState {}

// Fertilizer and Love are low
class Desolated: PlantState {}

// Fertilizer and water are low
class Abandoned: PlantState {}

// Love and water are low
class Withered: PlantState {}
