//
//  WatchManger.swift
//  CasioWatchApp
//
//  Created by Hadi Mrih on 02/03/2017.
//  Copyright © 2017 Hadi Mrih. All rights reserved.
//

import UIKit



class WatchManger: NSObject {

    
    let formatter = DateFormatter()
    var canEditTime : Bool = false
    let calendar = Calendar.current

    var watchInitStatesFuncArr : [()->(btnsPressed?)] = []
    var currentStateIndex : Int = 0
    var currentWatchState : btnsPressed?

    static var viewControllerDelegate : WatchViewController?
    
    func initState() {
        watchInitStatesFuncArr = [initTimeClass,initDateClass,initStoperClass] // Models init functions array
        currentWatchState = watchInitStatesFuncArr[currentStateIndex]()
    }
    
    func initTimeClass() -> btnsPressed? {
        
        let time = TimeClass()
        return time
    }
    
    func initDateClass() -> btnsPressed? {
        
        let date = DateClass()
        return date
    }
    
    func initStoperClass() -> btnsPressed? {
        
        let stoper = StoperClass()
        return stoper
    }

    func deinitCurrentClass() {
        
         currentWatchState?.changesBeforeDeinit?()
         currentWatchState = nil
    }
    
    func changeStateAnimation() -> Void {
        
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = "cube"
        slideInFromLeftTransition.subtype = kCATransitionFromLeft
        slideInFromLeftTransition.duration = 1
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromLeftTransition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        WatchManger.viewControllerDelegate?.view.layer.add(slideInFromLeftTransition, forKey:nil)
    }

    
    func btnPressed(btnSelectorId: String) {
        
        if btnSelectorId == "ChangeState" {
            
            self.changeStateAnimation()
            currentStateIndex += 1
            if currentStateIndex >= watchInitStatesFuncArr.count {
                
                currentStateIndex = 0
            }
            
            self.deinitCurrentClass()
            currentWatchState = watchInitStatesFuncArr[currentStateIndex]()

        } else {
            
            currentWatchState?.btnPressedFromProtocol?(btnSelectorId: btnSelectorId)
        }
    }
    
    func editing()
    {
        if canEditTime {
            
            canEditTime = false
            DispatchQueue.main.async {
                WatchManger.viewControllerDelegate?.btn2.setTitle("Edit", for: UIControlState.normal)
            }
            WatchManger.viewControllerDelegate?.displayLabel.alpha = 1
            WatchManger.viewControllerDelegate?.displayLabel.layer.removeAllAnimations()
            
        } else {
            
            canEditTime = true
            DispatchQueue.main.async {
                WatchManger.viewControllerDelegate?.btn2.setTitle("Save", for: UIControlState.normal)
            }
            UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
                WatchManger.viewControllerDelegate?.displayLabel.alpha = 0
            }, completion: nil)
        }
    }
    
    
}
