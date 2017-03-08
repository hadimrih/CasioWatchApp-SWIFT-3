//
//  BtnsPressedProtocol.swift
//  NewWatch
//
//  Created by Hadi Mrih on 07/03/2017.
//  Copyright © 2017 Hadi Mrih. All rights reserved.
//

import Foundation


@objc protocol CommonModelsActions {

   @objc optional func btnPressedFromProtocol(btnSelectorId: String)
   @objc optional func changesBeforeDeinit()

}
