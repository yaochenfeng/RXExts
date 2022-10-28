//
//  RXWebController.swift
//  RXExts
//
//  Created by yaochenfeng on 2022/10/27.
//

import UIKit
import WebKit

public extension RXWebController {
    convenience init(url: URL?) {
        self.init()
        self.initialURL = url
    }
    convenience init(string: String?) {
        if let str = string,
           let url = URL(string: str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? str) {
            self.init(url: url)
        } else {
            self.init(url: nil)
        }
    }
    
    /// 是否允许通用链接打开app
    public var allowAppLink: Bool {
        get {
            return allowActionPolicy == .allow
        }
        set {
            allowActionPolicy = newValue ? .allow : .init(rawValue: WKNavigationActionPolicy.allow.rawValue + 2) ?? .allow
        }
    }
}

open class RXWebController: UIViewController {
    public var webView = RXWebView.rx.new(.shared)
        .allowsLinkPreview(true)
        .allowsBackForwardNavigationGestures(true)
        .base
    
    var initialURL: URL?
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private var allowActionPolicy: WKNavigationActionPolicy = .allow
}

private extension RXWebController {
    func setupUI() {
        webView.rx.navigationDelegate(self)
            .add2(view).lyt { mk in
                mk.edges.equalToSuperview()
            }.load(initialURL)
    }
}

extension RXWebController: WKNavigationDelegate {
    open func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(allowActionPolicy)
    }
}
