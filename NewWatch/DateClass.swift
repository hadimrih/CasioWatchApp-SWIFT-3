//
//  DateClass.swift
//  CasioWatchApp
//
//  Created by Hadi Mrih on 02/03/2017.
//  Copyright © 2017 Hadi Mrih. All rights reserved.
//

import UIKit

class DateClass: WatchManger,btnsPressed
{

    var daysToAdd : Int = 0
    var monthsToAdd : Int = 0

    
    convenience init (viewControllerDelegate:WatchViewController?)
    {
        self.init()
        
        self.viewControllerDelegate = viewControllerDelegate
        let now = Date()
        formatter.dateFormat = "dd/MM/yyyy"
        DispatchQueue.main.async { [weak self] () in
            self?.viewControllerDelegate?.displayLabel.text = self?.formatter.string(from: now)
            self?.viewControllerDelegate?.btn2.setTitle("Edit", for: UIControlState.normal)
            self?.viewControllerDelegate?.btn3.setTitle("increase days", for: UIControlState.normal)
            self?.viewControllerDelegate?.btn4.setTitle("increase months", for: UIControlState.normal)
            self?.viewControllerDelegate?.currentStateLbl.text = "Date"
        }        
    }
    
    func updateTime()
    {
        var now = Date()
        formatter.dateFormat = "dd/MM/yyyy"
        now = calendar.date(byAdding: .day, value: daysToAdd, to: now)!
        now = calendar.date(byAdding: .month, value: monthsToAdd, to: now)!
        
        DispatchQueue.main.async { [weak self] () in
            self?.viewControllerDelegate?.displayLabel.text = self?.formatter.string(from: now)
        }
    }
    
    func btn2PressedFromProtocol()
    {
        self.editing()
    }
    
    func btn3PressedFromProtocol()
    {
        if canEditTime {
            daysToAdd += 1
            self.updateTime()
        }
    }
    
    func btn4PressedFromProtocol()
    {
        if canEditTime {
            monthsToAdd += 1
            self.updateTime()
        }
    }

   
    deinit {
        print("deinit date")
    }
    
}
