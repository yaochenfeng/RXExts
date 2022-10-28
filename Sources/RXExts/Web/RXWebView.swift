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
    }
}


