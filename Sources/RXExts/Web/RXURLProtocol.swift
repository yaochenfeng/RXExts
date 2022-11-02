//
//  RXURLProtocol.swift
//  RXExts
//
//  Created by yaochenfeng on 2022/10/28.
//

import UIKit
/// 网络资源静态化
public class RXURLProtocol: URLProtocol {
    /// 允许缓存
    public static var allowCache: (URLRequest) -> Bool = { _ in
        return true
    }
    public override class func canInit(with request: URLRequest) -> Bool {
        guard let scheme = request.url?.scheme,
              ["http","https"].contains(scheme),
              URLProtocol.property(forKey: tagKey, in: request) == nil,
              request.httpMethod?.lowercased() == "get",
              allowCache(request) else {
            return false
        }
        return true
    }
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    public override func startLoading() {
        //已有缓存
        if let cachedRes = URLCache.shared.cachedResponse(for: self.request) {
            client?.urlProtocol(self, didReceive: cachedRes.response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: cachedRes.data)
            client?.urlProtocolDidFinishLoading(self)
            return
        }
        logger.trace("网络拦截\(request.url?.absoluteString ?? "")")
        let newRequest = (request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
        URLProtocol.setProperty(true, forKey: Self.tagKey, in: newRequest)
        dataTask = URLSession.shared.dataTask(with: newRequest as URLRequest) { data, res, err in
            if let error = err {
                self.client?.urlProtocol(self, didFailWithError: error)
            } else if let data = data, let response = res {
                self.client?.urlProtocol(self, didLoad: data)
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                self.client?.urlProtocolDidFinishLoading(self)
                URLCache.shared.storeCachedResponse(CachedURLResponse(response: response, data: data, storagePolicy: .allowed), for: self.request)
            } else {
                logger.warning("网络返回\(res)")
            }
            
        }
        dataTask?.resume()
    }
    public override func stopLoading() {
        dataTask?.cancel()
    }
    
    //URLSession数据请求任务
    var dataTask: URLSessionDataTask?
    static let tagKey = "RXURLProtocolKey"
}

