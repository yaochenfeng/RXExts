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
}

open class RXWebController: UIViewController {
    public let webview = RXWebView.rx.new
    var initialURL: URL?
    open override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

private extension RXWebController {
    func commonInit() {
        webview.add2(view).lyt { mk in
            mk.edges.equalToSuperview()
        }
        if let url = initialURL {
            webview.load(url)
        }
    }
}
