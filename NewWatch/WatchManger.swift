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
    
    // change state btn
    func btn1Pressed() -> Void
    {
        currentStateIndex += 1
        if currentStateIndex >= watchInitStatesFuncArr.count
        {
            currentStateIndex = 0
        }
    
        self.deinitCurrentClass()
        currentWatchState = watchInitStatesFuncArr[currentStateIndex]()
    }
    
    func btn2Pressed() -> Void
    {
        currentWatchState?.btn2PressedFromProtocol?()
    }
    
    func btn3Pressed() -> Void
    {
        currentWatchState?.btn3PressedFromProtocol?()
    }
    
    func btn4Pressed() -> Void
    {
        currentWatchState?.btn4PressedFromProtocol?()
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
