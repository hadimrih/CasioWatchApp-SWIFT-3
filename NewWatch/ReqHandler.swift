//
//  ReqHandler.swift
//  MoblinTestSwift
//
//  Created by HADI MRIH on 29/11/2016.
//  Copyright © 2016 hadi. All rights reserved.
//

import UIKit

let SERVER_HOST = "http://api.timezonedb.com/v2/list-time-zone"

let API_KEY = "YTK4MOM2REQW"


class ReqHandler {

    var onComplete: ((_ resultOnComplete: Array<Any>)->())? //an optional function
    
    var faildOnComplete: ((_ faildOnComplete: Any)->())? //an optional function

   
    func GetTimeZonesList() {
        
        let urlstring = "\(SERVER_HOST)?key=\(API_KEY)&format=json"
        
        let urlwithPercentEscapes = urlstring.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        
        let url = URL(string: urlwithPercentEscapes!)
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error as Any)
                self.faildOnComplete?(error as AnyObject)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            var timeZonesArr : [Any] = []
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            
            timeZonesArr = json["zones"] as! [Any]
            
            self.onComplete?(timeZonesArr)

        }
        
        task.resume()
        
    }

}
