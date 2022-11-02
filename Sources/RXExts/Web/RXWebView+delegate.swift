//
//  WKWebView+delegate.swift
//  RXExts
//
//  Created by yaochenfeng on 2022/10/27.
//

import WebKit

/// 默认WKUIDelegate实现
extension RXWebView: WKUIDelegate {
    open func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController.init(title: nil, message: message, preferredStyle: .alert)
        
        let confirm = UIAlertAction.init(title: "完成", style: .default) { (action) in
            completionHandler()
        }
        alert.addAction(confirm)
        rx.controller?.present(alert, animated: true, completion: nil)
    }
    open func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alert = UIAlertController.init(title: prompt, message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = defaultText
        }
        let confirm = UIAlertAction.init(title: "完成", style: .default) { (action) in
            completionHandler(alert.textFields?.first?.text)
        }
        alert.addAction(confirm)
        rx.controller?.present(alert, animated: true, completion: nil)
    }
    
    /// 会拦截到window.open()事件.只需要我们在在方法内进行处理
    open func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        } else if !(navigationAction.targetFrame?.isMainFrame)! {
            webView.load(navigationAction.request)
        }
        return nil
    }
}

extension RXWebView: WKNavigationDelegate {
    open func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        
        let allow = decidePolicyForAction(navigationAction)
        let action: WKNavigationActionPolicy = allow ? allowActionPolicy : .cancel
        decisionHandler(action)
    }
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(decidePolicyForResponse(navigationResponse) ? .allow : .cancel)
    }
}
