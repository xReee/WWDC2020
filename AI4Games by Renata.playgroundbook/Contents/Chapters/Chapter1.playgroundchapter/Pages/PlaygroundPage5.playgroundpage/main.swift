
//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//
import PlaygroundSupport
import UIKit

//#-end-hidden-code
/*:
### Definitely: the game is much better. But there is another problem, do you want to know what is?
 
 # Press run to discover!

spoiler: We are going to talk about decision tree!
 
> First press **run the code** to listen me explain what's wrong in the last game session, then we are going to use the code below to improve it.
  */
let skipTalk = /*#-editable-code*/false/*#-end-editable-code*/  // Use it after run
 
//#-hidden-code
let decisionTree = ThirdCutScene(skipTalk)
//#-end-hidden-code

//: ## Old States
decisionTree.when(condition: .everythingFine, changeStateFor: .normal)
decisionTree.when(condition: .lowFertilizer, changeStateFor: .hungry)
decisionTree.when(condition: .lowLove, changeStateFor: .lonely)
decisionTree.when(condition: .lowWater, changeStateFor: .thirsty)
//: ## New States
//: ---
//: ### Abandoned = Hungry + Thirsty
decisionTree.when(condition: ./*#-editable-code condition name*/none/*#-end-editable-code*/, and: ./*#-editable-code condition name*/none/*#-end-editable-code*/, changeStateFor: .abandoned)
//: ### Desolated = Hungry + Lonely
decisionTree.when(condition: ./*#-editable-code condition name*/none/*#-end-editable-code*/, and: ./*#-editable-code condition name*/none/*#-end-editable-code*/, changeStateFor: .desolated)
//: ### Withered = Lonely + Thirsty
decisionTree.when(condition: ./*#-editable-code condition name*/none/*#-end-editable-code*/, and: ./*#-editable-code condition name*/none/*#-end-editable-code*/, changeStateFor: .withered)
//: ### Zombie = Hungry + Lonely + Thirsty
decisionTree.when(condition: ./*#-editable-code condition name*/none/*#-end-editable-code*/, and: ./*#-editable-code condition name*/none/*#-end-editable-code*/, and: ./*#-editable-code condition name*/none/*#-end-editable-code*/, changeStateFor: .zombie)

//#-hidden-code
PlaygroundPage.current.setLiveView(decisionTree)
//#-end-hidden-code
