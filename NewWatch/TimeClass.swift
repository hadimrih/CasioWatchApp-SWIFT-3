//
//  TimeClass.swift
//  CasioWatchApp
//
//  Created by Hadi Mrih on 02/03/2017.
//  Copyright © 2017 Hadi Mrih. All rights reserved.
//

import UIKit

class TimeClass: WatchManger,btnsPressed {

  
    var minutesToAdd : Int = 0
    var hoursToAdd : Int = 0
    var canUpdateTime : Bool = true

    convenience init (viewControllerDelegate:WatchViewController?)
    {
        self.init()

        self.viewControllerDelegate = viewControllerDelegate
        
        let now = Date()
        formatter.dateFormat = "hh:mm:ss"
        DispatchQueue.main.async { [weak self] () in
            self?.viewControllerDelegate?.displayLabel.text = self?.formatter.string(from: now)
            self?.viewControllerDelegate?.btn2.setTitle("Edit", for: UIControlState.normal)
            self?.viewControllerDelegate?.btn3.setTitle("increase minutes", for: UIControlState.normal)
            self?.viewControllerDelegate?.btn4.setTitle("increase hours", for: UIControlState.normal)
            self?.viewControllerDelegate?.currentStateLbl.text = "Time"
        }
        
        self.upDateTime()
    }
    
    
    func upDateTime() {
        
        var now = Date()
        formatter.dateFormat = "hh:mm:ss"
        
       // formatter.timeZone = currentTimeZone
        
        now = calendar.date(byAdding: .minute, value: minutesToAdd, to: now)!
        now = calendar.date(byAdding: .hour, value: hoursToAdd, to: now)!
        
        DispatchQueue.main.async { [weak self] () in
            self?.viewControllerDelegate?.displayLabel.text = self?.formatter.string(from: now)
        }
        
        if canUpdateTime {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: { [weak self] () in
                self?.upDateTime()
            })
        }
    }
    
    func btn2PressedFromProtocol()
    {
       self.editing()
    }
    
    func btn3PressedFromProtocol()
    {
        if canEditTime {
            minutesToAdd += 1
        }
    }
    
    func btn4PressedFromProtocol()
    {
        if canEditTime {
            hoursToAdd += 1
        }
    }
   
    
    deinit {
        canUpdateTime = false
        print("deinit time")

    }
    
    
}
