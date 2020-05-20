
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
 ### Hi again! It was nice to play. Do you know that we can improve the gameplay? We can use state machines for it. Let's talk about it.
 # Press run!
 ---
> First press **run the code** to listen me explain what's wrong in the last game session, then we are going to use the code below to improve it.
  */
let skipTalk = /*#-editable-code*/false/*#-end-editable-code*/  // Use it after run
//#-hidden-code
let stateMachine = SecondCutScene(skipTalk)
//#-end-hidden-code
//: ## Normal
stateMachine.add(state: .normal, withCondition: .everythingFine)
//: ## Hungry
stateMachine.add(state: ./*#-editable-code state name*/hungry/*#-end-editable-code*/,  withCondition: ./*#-editable-code condition name*/none/*#-end-editable-code*/)
//: ## Thirsty
stateMachine.add(state: ./*#-editable-code state name*/thirsty/*#-end-editable-code*/,  withCondition: ./*#-editable-code condition name*/none/*#-end-editable-code*/)
//: ## Lonely
stateMachine.add(state: ./*#-editable-code state name*/lonely/*#-end-editable-code*/,  withCondition: ./*#-editable-code condition name*/none/*#-end-editable-code*/)
//#-hidden-code
PlaygroundPage.current.setLiveView(stateMachine)
//#-end-hidden-code

