//
//  ResponseReceiver.swift
//  Aplicacion
//
//  Created by dam on 8/2/17.
//  Copyright © 2017 Andres. All rights reserved.
//

import Foundation

protocol ResponseReceiver {
    func onDataReceived (data: Data)
    func onErrorReceivingData(message:String)
}
