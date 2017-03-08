//
//  StoperClass.swift
//  CasioWatchApp
//
//  Created by Hadi Mrih on 02/03/2017.
//  Copyright © 2017 Hadi Mrih. All rights reserved.
//

import UIKit

class StoperClass: WatchManger,CommonModelsActions {

    var stoperTimer: Timer = Timer()
    var currentTime = 0
    var currentBackgroundDate = Date()

    override init() {
        
        super.init()
        
        DispatchQueue.main.async {
            WatchManger.viewControllerDelegate?.displayLabel.text = "00:00:00"
            WatchManger.viewControllerDelegate?.btn2.setTitle("Start stopper", for: UIControlState.normal)
            WatchManger.viewControllerDelegate?.btn3.setTitle("Stop stopper", for: UIControlState.normal)
            WatchManger.viewControllerDelegate?.btn4.setTitle("Pause stopper", for: UIControlState.normal)
            WatchManger.viewControllerDelegate?.currentStateLbl.text = "Stoper"
        }
        
        self.startApp()
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(pauseApp), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(startApp), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)

    }
    
    func startApp() {
        
        if  (UserDefaults.standard.value(forKey: "currentTime") != nil && UserDefaults.standard.value(forKey: "currentBackgroundDate") != nil ) {
            
            currentTime = UserDefaults.standard.value(forKey: "currentTime") as! Int
            currentBackgroundDate = UserDefaults.standard.value(forKey: "currentBackgroundDate") as! Date
        }
        
        // check if the timer was working before resuming it again
        if currentTime != 0 {
            let difference = currentBackgroundDate.timeIntervalSince(Date())
            let absDifference = abs(Int(difference))
            currentTime += absDifference
            self.start() //start timer
        }
    }
    
    func pauseApp() {
        
        self.pause() //invalidate timer
        currentBackgroundDate = Date()
        
        UserDefaults.standard.setValue(currentBackgroundDate, forKey: "currentBackgroundDate")
        UserDefaults.standard.setValue(currentTime, forKey: "currentTime")
        
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
        
        self.start()
    }
    
    func btn3Pressed() {
        
        self.stop()
    }
    
    func btn4Pressed() {
        
        self.pause()
    }
    
    func start() -> Void {
        
        if stoperTimer.isValid {
            stoperTimer.invalidate()
        }
        
        if currentTime == 0 {
            
            DispatchQueue.main.async {
                WatchManger.viewControllerDelegate?.displayLabel.text = "00:00:00"
            }
        }
        
        stoperTimer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(updateTime),
                                     userInfo: nil,
                                     repeats: true)
    }

    func stop() -> Void {
        
        currentTime = 0
        stoperTimer.invalidate()
        UserDefaults.standard.removeObject(forKey: "currentTime")
    }
    
    func pause() -> Void {
        
        if stoperTimer.isValid {
            stoperTimer.invalidate()
        } else {
            self.start()
        }
    }

  
    func updateTime() {
        
        currentTime += 1
        
        let (h,m,s) = secondsToHoursMinutesSeconds(seconds: currentTime)
        
        DispatchQueue.main.async { [weak self] () in
            WatchManger.viewControllerDelegate?.displayLabel.text = "\(self!.timeText(from: h)):\(self!.timeText(from: m)):\(self!.timeText(from: s))"
        }
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    private func timeText(from number: Int) -> String {
        return number < 10 ? "0\(number)" : "\(number)"
    }
    
    func changesBeforeDeinit() {
        
        stoperTimer.invalidate()
    }
    
    deinit {
        
        print("deinit stoper")
        stoperTimer.invalidate()
        currentBackgroundDate = Date()
        UserDefaults.standard.setValue(currentBackgroundDate, forKey: "currentBackgroundDate")
        if currentTime > 0 {
          UserDefaults.standard.setValue(currentTime, forKey: "currentTime")
        }
    }
    
}
