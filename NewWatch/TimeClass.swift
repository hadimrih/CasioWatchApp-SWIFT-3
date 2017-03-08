//
//  TimeClass.swift
//  CasioWatchApp
//
//  Created by Hadi Mrih on 02/03/2017.
//  Copyright © 2017 Hadi Mrih. All rights reserved.
//

import UIKit
import SwiftSpinner

class TimeClass: WatchManger,CommonModelsActions {

  
    var minutesToAdd : Int = 0
    var hoursToAdd : Int = 0
    var canUpdateTime : Bool = true
    
    var currentTimeZone : TimeZone = TimeZone.current
    let notificationName = Notification.Name("timeZoneChanged")

    
    override init() {
        
        super.init()
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeTimeZone), name: notificationName, object: nil)
        let now = Date()
        formatter.dateFormat = "hh:mm:ss"
        DispatchQueue.main.async { [weak self] () in
            WatchManger.viewControllerDelegate?.displayLabel.text = self?.formatter.string(from: now)
            WatchManger.viewControllerDelegate?.btn2.setTitle("Edit", for: UIControlState.normal)
            WatchManger.viewControllerDelegate?.btn3.setTitle("increase minutes", for: UIControlState.normal)
            WatchManger.viewControllerDelegate?.btn4.setTitle("increase hours", for: UIControlState.normal)
            WatchManger.viewControllerDelegate?.currentStateLbl.text = "Time"
            WatchManger.viewControllerDelegate?.changeTimeZoneBtn.isHidden = false
        }
        
        self.upDateTime()
    }
    
    func upDateTime() {
        
        var now = Date()
        formatter.dateFormat = "hh:mm:ss"
        
        formatter.timeZone = currentTimeZone
        
        now = calendar.date(byAdding: .minute, value: minutesToAdd, to: now)!
        now = calendar.date(byAdding: .hour, value: hoursToAdd, to: now)!
        
        DispatchQueue.main.async { [weak self] () in
            WatchManger.viewControllerDelegate?.displayLabel.text = self?.formatter.string(from: now)
        }
        
        if canUpdateTime {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: { [weak self] () in
                self?.upDateTime()
            })
        }
    }
    
    func btnPressedFromProtocol(btnSelectorId: String) {
        
        let aSel : Selector = NSSelectorFromString(btnSelectorId)
        
        if self.responds(to: aSel)
        {
            performSelector(onMainThread: aSel, with: nil, waitUntilDone: true)
        }else
        {
            print("No selector with this Button Restoration ID: \"\(btnSelectorId)\"")
        }
    }
    
    func btn2Pressed() {
        
       self.editing()
    }
    
    func btn3Pressed() {
        
        if canEditTime {
            minutesToAdd += 1
        }
    }
    
    func btn4Pressed() {
        
        if canEditTime {
            hoursToAdd += 1
        }
    }
    
    func changeTimeZoneBtnPressed() {
        
        if Singleton.sharedInstance.timeZonesArr.count > 0 {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "TimeZonesViewController") as! TimeZonesViewController
            
            controller.timeZonesArr = Singleton.sharedInstance.timeZonesArr
            WatchManger.viewControllerDelegate?.present(controller, animated: true, completion: nil)
            
            return
        }
        
        SwiftSpinner.show("Loading TimeZones...")
        let reqHandler = ReqHandler()
        reqHandler.GetTimeZonesList()
        reqHandler.onComplete = { timeZonesArr in
            
            Singleton.sharedInstance.timeZonesArr = timeZonesArr
            
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "TimeZonesViewController") as! TimeZonesViewController
                
                controller.timeZonesArr = timeZonesArr
                WatchManger.viewControllerDelegate?.present(controller, animated: true, completion: nil)
                
                SwiftSpinner.hide()
                
            }
        }
        reqHandler.faildOnComplete = { error in
            
            SwiftSpinner.hide()
            
            let alert = UIAlertController(title: "Please try again later", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "ok, thanks", style: UIAlertActionStyle.default, handler: nil))
            WatchManger.viewControllerDelegate?.present(alert, animated: true, completion: nil)
        }
    }
    
    func didChangeTimeZone(withNotification notification : NSNotification) {
        currentTimeZone = TimeZone.init(identifier: notification.object! as! String)!
    }

   
    
    deinit {
        canUpdateTime = false
        WatchManger.viewControllerDelegate?.changeTimeZoneBtn.isHidden = true
        NotificationCenter.default.removeObserver(self, name: notificationName, object: nil);
        print("deinit time")
    }
    
    
}
