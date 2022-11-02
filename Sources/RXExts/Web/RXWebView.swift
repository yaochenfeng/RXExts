//
//  RXWebView.swift
//  RXExts
//
//  Created by yaochenfeng on 2022/10/27.
//

import UIKit
import WebKit
import RxCocoa


/// 封装常用webview
open class RXWebView: WKWebView {
    required public override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: .zero, configuration: configuration)
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    var config: RXWebConfig = .init()
    var progressView = UIProgressView.rx.new.isHidden(true)
    public var decidePolicyForAction: (WKNavigationAction) -> Bool = { _ in
        return true
    }
    public var decidePolicyForResponse: (WKNavigationResponse) -> Bool = { _ in
        return true
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
    internal var allowActionPolicy: WKNavigationActionPolicy = .allow
}


private extension RXWebView {
    func commonInit() {
        uiDelegate = self
        weak var weakSelf = self
        let progress = rx.estimatedProgress
        progressView.add2(self)
            .trackTintColor(.clear)
            .lyt { mk in
                mk.top.leading.trailing.equalTo(rx.safeAreaLayoutGuide)
                mk.height.equalTo(3)
            }.progress(progress)
            .isHidden(progress.map{$0 == 1}.distinctUntilChanged())
        rx.setDelegate(self)
    }
}

