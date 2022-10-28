//
//  RXURLProtocol.swift
//  RXExts
//
//  Created by yaochenfeng on 2022/10/28.
//

import UIKit

/// 网络资源静态化
class RXURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        guard URLProtocol.property(forKey: tagKey, in: request) == nil else {
            return false
        }
        return true
    }
    
    static let tagKey = "RXURLProtocolKey"
}
