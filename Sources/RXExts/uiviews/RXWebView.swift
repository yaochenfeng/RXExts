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
    /// 共享cookie等
    public static let processPool = WKProcessPool()
    public override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: .zero, configuration: configuration)
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    var progress = UIProgressView.rx.new
}

private extension RXWebView {
    func commonInit() {
        uiDelegate = self
        progress.add2(self).lyt { mk in
            mk.top.leading.trailing.equalTo(rx.safeAreaLayoutGuide)
            mk.height.equalTo(1)
        }.progress(rx.estimatedProgress)
            .isHidden(rx.estimatedProgress.map{$0 == 1 }.distinctUntilChanged())
    }
}


