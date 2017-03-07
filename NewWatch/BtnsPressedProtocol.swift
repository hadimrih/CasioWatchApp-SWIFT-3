//
//  BtnsPressedProtocol.swift
//  NewWatch
//
//  Created by Hadi Mrih on 07/03/2017.
//  Copyright © 2017 Hadi Mrih. All rights reserved.
//

import Foundation


@objc protocol btnsPressed {

   @objc optional func btn2PressedFromProtocol()
   @objc optional func btn3PressedFromProtocol()
   @objc optional func btn4PressedFromProtocol()
   @objc optional func changesBeforeDeinit()

}
