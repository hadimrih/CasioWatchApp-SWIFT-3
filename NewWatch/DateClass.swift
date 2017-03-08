//
//  DateClass.swift
//  CasioWatchApp
//
//  Created by Hadi Mrih on 02/03/2017.
//  Copyright © 2017 Hadi Mrih. All rights reserved.
//

import UIKit

class DateClass: WatchManger,CommonModelsActions
{

    var daysToAdd : Int = 0
    var monthsToAdd : Int = 0

    override init() {
        
        super.init()
        
        let now = Date()
        formatter.dateFormat = "dd/MM/yyyy"
        DispatchQueue.main.async { [weak self] () in
            WatchManger.viewControllerDelegate?.displayLabel.text = self?.formatter.string(from: now)
            WatchManger.viewControllerDelegate?.btn2.setTitle("Edit", for: UIControlState.normal)
            WatchManger.viewControllerDelegate?.btn3.setTitle("increase days", for: UIControlState.normal)
            WatchManger.viewControllerDelegate?.btn4.setTitle("increase months", for: UIControlState.normal)
            WatchManger.viewControllerDelegate?.currentStateLbl.text = "Date"
        }

    }
    
    
    func updateTime() {
        
        var now = Date()
        formatter.dateFormat = "dd/MM/yyyy"
        now = calendar.date(byAdding: .day, value: daysToAdd, to: now)!
        now = calendar.date(byAdding: .month, value: monthsToAdd, to: now)!
        
        DispatchQueue.main.async { [weak self] () in
            WatchManger.viewControllerDelegate?.displayLabel.text = self?.formatter.string(from: now)
        }
    }
    
    func btnPressedFromProtocol(btnSelectorId: String) {
        
        let aSel : Selector = NSSelectorFromString(btnSelectorId)
        
        if self.responds(to: aSel) {
            performSelector(onMainThread: aSel, with: nil, waitUntilDone: true)
        } else {
            print("No selector with this Button Restoration ID: \"\(btnSelectorId)\"")
        }
    }
    
    func btn2Pressed() {
        
        self.editing()
    }
    
    func btn3Pressed() {
        
        if canEditTime {
            daysToAdd += 1
            self.updateTime()
        }
    }
    
    func btn4Pressed() {
        
        if canEditTime {
            monthsToAdd += 1
            self.updateTime()
        }
    }

    deinit {
        print("deinit date")
    }
    
}
