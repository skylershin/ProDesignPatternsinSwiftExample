//
//  Logger.swift
//  SportsStore
//
//  Created by MunkyuShin on 5/7/16.
//  Copyright © 2016 munkyu. All rights reserved.
//

import Foundation

let productLogger = Logger<Product>(callback: {p in
    print("Change: \(p.name) \(p.stockLevel) items in stick")
})

final class Logger<T where T:NSObject, T:NSCopying> {
    var dataItems:[T] = []
    var callback:(T) -> Void
    var arrayQ = dispatch_queue_create("arrayQ", DISPATCH_QUEUE_CONCURRENT)
    var callbackQ = dispatch_queue_create("callbackQ", DISPATCH_QUEUE_SERIAL)
    
    private init(callback:T -> Void, protect:Bool = true) {
        self.callback = callback
        
        if protect {
            self.callback = {(item:T) in
                dispatch_sync(self.callbackQ, {
                    callback(item)
                })
            }
        }
    }
    
    func logItem(item: T) {
        dispatch_barrier_async(arrayQ, {() in
            self.dataItems.append(item.copy() as! T)
            self.callback(item)
        })
    }
    
    func processItems(callback:T -> Void)  {
        dispatch_sync(arrayQ) { 
            for item in self.dataItems {
                callback(item)
            }
        }
    }
    
}