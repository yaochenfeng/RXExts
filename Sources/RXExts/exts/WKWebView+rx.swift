import WebKit
import RxCocoa

extension Reactive where Base: WKWebView {
    /// title
    public var title: Observable<String?> {
        return self.observeWeakly(String.self, "title")
    }
    
    /// loading
    public var isLoading: Observable<Bool> {
        return self.observeWeakly(Bool.self, "isLoading")
            .map { $0 ?? false }
    }
    
    /// 网页上的所有资源是否已通过 https 加载
    public var hasOnlySecureContent: Observable<Bool> {
        return self.observeWeakly(Bool.self, "hasOnlySecureContent")
            .map { $0 ?? false }
    }
    /// estimatedProgress
    public var estimatedProgress: Observable<Float> {
        return self.observeWeakly(Double.self, "estimatedProgress")
            .map { Float($0 ?? 0.0) }
    }
    /// url
    public var url: Observable<URL?> {
        return self.observeWeakly(URL.self, "url")
    }
    /// canGoBack
    public var canGoBack: Observable<Bool> {
        return self.observeWeakly(Bool.self, "canGoBack")
            .map { $0 ?? false }
    }
    /// canGoForward
    public var canGoForward: Observable<Bool> {
        return self.observeWeakly(Bool.self, "canGoForward")
            .map { $0 ?? false }
    }
    
    
    static var new: Reactive<Base> {
        let config = WKWebViewConfiguration.rx.new.then { config in
            config.processPool = RXWebView.processPool
        }
        return Base(frame: .zero, configuration: config).rx
    }
    
    
    @discardableResult func load(_ url: URL) -> WKNavigation? {
        return base.load(URLRequest(url: url))
    }
}
