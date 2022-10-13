#if canImport(UIKit)
import UIKit

public protocol RxViewable {
    var rxView: UIView { get }
}

extension UIView: RxViewable {
    public var rxView: UIView {
        return self
    }
}

extension Reactive: RxViewable where Base: UIView {
    public var rxView: UIView {
        return base
    }
    @discardableResult public func addSubview(_ v: RxViewable) -> Self {
        base.addSubview(v.rxView)
        return self
    }
}

public extension Reactive where Base: UIStackView {
    @discardableResult static func new(
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat = 0,
        @ArrayBuilder<RxViewable> builder: () -> [RxViewable]
    ) -> Self {
        return new.axis(axis).spacing(spacing)
            .addArranged(builder: builder)
    }
    /// 添加管理子视图rxView
    @discardableResult func addArranged(@ArrayBuilder<RxViewable> builder: () -> [RxViewable]) -> Self {
        let views = builder()
        for sub in views {
            base.addArrangedSubview(sub.rxView)
        }
        return self
    }
}
#endif
