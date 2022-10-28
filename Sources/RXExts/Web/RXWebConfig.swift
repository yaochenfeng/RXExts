//
//  RXWebConfig.swift
//  RXExts
//
//  Created by yaochenfeng on 2022/10/28.
//

import WebKit
import RxCocoa

/// 配置web相关
public struct RXWebConfig {
    public static var shared = RXWebConfig(cached: true)
    public init(cached: Bool = false) {
        enableCached = cached
    }
    /// 是否使用缓存加速
    public var enableCached: Bool
    /// 共享cookie等
    public var processPool = WKProcessPool()
    /// 加速白名单
    public var hostWhite: [String] = []
    
    static let scheme = "h5"
}

extension RXWebConfig {
    @available(iOS 11.0, *)
    public class H5SchemeHandler: NSObject, WKURLSchemeHandler {
        public func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
            let req = urlSchemeTask.request.replace(scheme: RXWebConfig.scheme, newValue: "http")
            
            let task = URLSession.shared.dataTask(with: req) {
                [weak self] data, resposne, err in
                guard err == nil, let resposne = resposne, let data = data else {
                    urlSchemeTask.didFailWithError(err ?? RxCocoaError.unknown)
                    return
                }
                urlSchemeTask.didReceive(resposne)
                urlSchemeTask.didReceive(data)
                urlSchemeTask.didFinish()
            }
            task.resume()
        }
        
        public func webView(_ webView: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {}
    }
}

extension RXWebView {
    open override func load(_ request: URLRequest) -> WKNavigation? {
        if #available(iOS 11.0, *), config.enableCached {
            return super.load(request.replace(scheme: "http", newValue: RXWebConfig.scheme))
        }

        return super.load(request)
    }
}
extension URLRequest {
    fileprivate func replace(scheme: String, newValue: String) -> URLRequest {
        guard let url = url,
              var comps = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return self
        }
        var old = self
        comps.scheme = comps.scheme?.replacingOccurrences(of: scheme, with: newValue)
        old.url = comps.url
        return old
    }
}
