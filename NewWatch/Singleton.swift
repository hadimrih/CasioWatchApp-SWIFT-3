//
//  Singleton.swift
//  CasioWatchApp
//
//  Created by Hadi Mrih on 04/03/2017.
//  Copyright © 2017 Hadi Mrih. All rights reserved.
//

import UIKit

class Singleton: NSObject {
    
    static let sharedInstance : Singleton = {
        let instance = Singleton()
        return instance
    }()
    
    var timeZonesArr : [Any] = []
    

}
