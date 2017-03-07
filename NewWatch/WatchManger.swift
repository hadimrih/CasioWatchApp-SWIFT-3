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
    var currentWatchStateObj : Any?

    var viewControllerDelegate : WatchViewController?
    
    convenience init(viewControllerDelegate:WatchViewController?)
    {
        self.init()
        self.viewControllerDelegate = viewControllerDelegate
        watchInitStatesFuncArr = [initTimeClass,initDateClass,initStoperClass]
        currentWatchState = watchInitStatesFuncArr[currentStateIndex]()

    }
    
    func initTimeClass() -> btnsPressed?
    {
        let time = TimeClass.init(viewControllerDelegate: self.viewControllerDelegate )
        currentWatchStateObj = time
        return time
    }
    
    func initDateClass() -> btnsPressed?
    {
        let date = DateClass.init(viewControllerDelegate: self.viewControllerDelegate )
        currentWatchStateObj = date
        return date
    }
    
    func initStoperClass() -> btnsPressed?
    {
        let stoper = StoperClass.init(viewControllerDelegate: self.viewControllerDelegate )
        currentWatchStateObj = stoper
        return stoper
    }

    
    
    func deinitCurrentClass()
    {
         currentWatchState?.changesBeforeDeinit?()
         currentWatchStateObj = nil
    }
    
    func changeStateAnimation() -> Void {
        
        DispatchQueue.main.async { [weak self] () in
            // Create a CATransition animation
            let slideInFromLeftTransition = CATransition()
            
            // Customize the animation's properties
            slideInFromLeftTransition.type = "cube"
            slideInFromLeftTransition.subtype = kCATransitionFromLeft
            slideInFromLeftTransition.duration = 1
            slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            slideInFromLeftTransition.fillMode = kCAFillModeRemoved
            
            // Add the animation to the View's layer
            self?.viewControllerDelegate?.view.layer.add(slideInFromLeftTransition, forKey:nil)
        }
    }
    
    
    // change state btn
    func btnPressed(btnSelectorId: String)
    {
        if btnSelectorId == "ChangeState"
        {
            self.changeStateAnimation()
            currentStateIndex += 1
            if currentStateIndex >= watchInitStatesFuncArr.count
            {
                currentStateIndex = 0
            }
            
            self.deinitCurrentClass()
            currentWatchState = watchInitStatesFuncArr[currentStateIndex]()

        }else
        {
            currentWatchState?.btnPressedFromProtocol?(btnSelectorId: btnSelectorId)
        }
    }
    
    func editing()
    {
        if canEditTime {
            canEditTime = false
            DispatchQueue.main.async { [weak self] () in
                self?.viewControllerDelegate?.btn2.setTitle("Edit", for: UIControlState.normal)
            }
            self.viewControllerDelegate?.displayLabel.alpha = 1
            self.viewControllerDelegate?.displayLabel.layer.removeAllAnimations()
        }else
        {
            canEditTime = true
            DispatchQueue.main.async { [weak self] () in
                self?.viewControllerDelegate?.btn2.setTitle("Save", for: UIControlState.normal)
            }
            UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
                self.viewControllerDelegate?.displayLabel.alpha = 0
            }, completion: nil)
        }
    }
    
    
}
