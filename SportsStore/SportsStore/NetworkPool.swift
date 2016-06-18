//
//  NetworkPool.swift
//  SportsStore
//
//  Created by MunkyuShin on 5/28/16.
//  Copyright © 2016 munkyu. All rights reserved.
//

import Foundation

final class NetworkPool {
    private let connectionCount = 3
    private var connections = [NetworkConnection]()
    private var semaphore:dispatch_semaphore_t
    private var queue:dispatch_queue_t
    
    private init() {
        for _ in 0 ..< connectionCount {
            connections.append(NetworkConnection())
        }
        semaphore = dispatch_semaphore_create(connectionCount)
        queue = dispatch_queue_create("networkpoolQ", DISPATCH_QUEUE_SERIAL)
    }
    
    private func doGetConnection() -> NetworkConnection {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        var result: NetworkConnection? = nil
        dispatch_sync(queue) { 
            result = self.connections.removeAtIndex(0)
        }
        return result!
    }
    
    private func doReturnConnection(conn:NetworkConnection) {
        dispatch_async(queue) { 
            self.connections.append(conn)
            dispatch_semaphore_signal(self.semaphore)
        }
    }
    
    class func getConnection() -> NetworkConnection {
      return sharedInstance.doGetConnection()
    }
    
    class func returnConnection(conn:NetworkConnection) {
        sharedInstance.doReturnConnection(conn)
    }
    
    private class var sharedInstance:NetworkPool {
        get {
            struct SingletonWrapper {
                static let singleton = NetworkPool()
            }
            return SingletonWrapper.singleton
        }
    }
}