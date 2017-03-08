//
//  TimeZonesViewController.swift
//  CasioWatchApp
//
//  Created by Hadi Mrih on 04/03/2017.
//  Copyright © 2017 Hadi Mrih. All rights reserved.
//

import UIKit

class TimeZonesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblView: UITableView!
  
    var timeZonesArr : [Any] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeZoneCell", for: indexPath as IndexPath) as! TimeZoneCell
        
        if let timeZoneObj = self.timeZonesArr[indexPath.row] as? [String:Any]
        {
            cell.countryNameLbl.text = timeZoneObj["countryName"] as! String?
            cell.zoneNameLbl.text = timeZoneObj["zoneName"] as! String?
            cell.countryCodeLbl.text = timeZoneObj["countryCode"] as! String?
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let timeZoneObj = self.timeZonesArr[indexPath.row] as? [String:Any]
        {
            let notificationName = Notification.Name("timeZoneChanged")
            
            NotificationCenter.default.post(name: notificationName, object: timeZoneObj["zoneName"] as! String?)
        }
        
        self.cancelBtnPressed(nil)
    }
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.timeZonesArr.count
    }

    
    @IBAction func cancelBtnPressed(_ sender: UIButton?)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
