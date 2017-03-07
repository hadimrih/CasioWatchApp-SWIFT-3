//
//  WatchViewController.swift
//  CasioWatchApp
//
//  Created by Hadi Mrih on 02/03/2017.
//  Copyright © 2017 Hadi Mrih. All rights reserved.
//

import UIKit


class WatchViewController: UIViewController {

    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var currentStateLbl: UILabel!

    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var btn2: UIButton!
    
    @IBOutlet weak var btn3: UIButton!
    
    @IBOutlet weak var btn4: UIButton!
    
    var watchManger : WatchManger?

    override func viewDidLoad() {
        super.viewDidLoad()

        watchManger = WatchManger.init(viewControllerDelegate: self)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn1Pressed(_ sender: UIButton)
    {
        print("\(sender.restorationIdentifier)")
        self.changeStateAnimation()
        watchManger?.btn1Pressed()
    }
    
    @IBAction func btn2Pressed(_ sender: UIButton)
    {
        watchManger?.btn2Pressed()
    }
    
    @IBAction func btn3Pressed(_ sender: UIButton)
    {
        watchManger?.btn3Pressed()
    }
    
    @IBAction func btn4Pressed(_ sender: UIButton)
    {
        watchManger?.btn4Pressed()
    }
        
    func changeStateAnimation() -> Void {
        
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = "cube"
        slideInFromLeftTransition.subtype = kCATransitionFromLeft
        slideInFromLeftTransition.duration = 1
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromLeftTransition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        self.view.layer.add(slideInFromLeftTransition, forKey:nil)
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
