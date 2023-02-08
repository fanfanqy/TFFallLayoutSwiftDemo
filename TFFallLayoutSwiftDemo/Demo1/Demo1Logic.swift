//
//  Demo1Logic.swift
//  TFFallLayoutSwiftDemo
//
//  Created by 范庆宇 on 2023/2/7.
//

import UIKit
import Foundation
typealias CompleteBlock = (_ success:Bool) -> Void

class Demo1Logic: NSObject {
    
    static func logic1(params:Dictionary<String,AnyObject>?, completion: CompleteBlock?) {
        print("业务方案1")
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            if params != nil {
                completion?(true)
            }else {
                completion?(false)
            }
        }
    }
    
    static func logic2(params:Dictionary<String,AnyObject>?, completion: CompleteBlock?) {
        print("业务方案2")
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            if params != nil {
                completion?(true)
            }else {
                completion?(false)
            }
        }
        
    }
}
