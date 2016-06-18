//
//  NetworkConnection.swift
//  SportsStore
//
//  Created by MunkyuShin on 5/28/16.
//  Copyright © 2016 munkyu. All rights reserved.
//

import Foundation

class NetworkConnection {
    
    private let storckData: [String: Int] = [
        "Kayak": 10, "Lifejacket": 14, "Soccer Ball": 32, "Corner Flags": 1,
        "Stadium": 4, "Thinking Cap": 8, "Unsteady Chair": 3,
        "Human Chess Board": 2, "Bling-Bling King": 4
    ]
    
    func getStockLevel(name: String) -> Int? {
        NSThread.sleepForTimeInterval(Double(rand() % 2))
        return storckData[name]
    }
}