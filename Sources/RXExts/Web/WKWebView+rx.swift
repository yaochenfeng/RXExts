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
    
    
    @discardableResult func load(_ tmp: URL?) -> WKNavigation? {
        guard let url = tmp else { return nil }
        return base.load(URLRequest(url: url))
    }
    
}
public extension Reactive where Base: RXWebView {
    static func new(_ config: RXWebConfig) -> Reactive<Base> {
        let webConfig = WKWebViewConfiguration.rx.new.then { config in
            config.processPool = config.processPool
            config.allowsInlineMediaPlayback = true
            if #available(iOS 11.0, *) {
                config.setURLSchemeHandler(RXWebConfig.H5SchemeHandler(), forURLScheme: "h5")
                config.setURLSchemeHandler(RXWebConfig.H5SchemeHandler(), forURLScheme: "h5s")
            }
        }
        return Base(
            frame: .zero,
            configuration: webConfig
        ).rx.chain { base in
            base.config = config
        }
    }
}
