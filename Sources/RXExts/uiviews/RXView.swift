#if canImport(UIKit)
import UIKit

open class RXUIView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commom()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commom()
    }
    /// 可继承修改
    open func setupUI() {}
    
    /// 宽高默认自适应
    public var intrinsicSize = CGSize(
        width: UIView.noIntrinsicMetric,
        height: UIView.noIntrinsicMetric
    ) {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    /// 合适大小
    open override var intrinsicContentSize: CGSize {
        if isHidden {
            return .zero
        }
        return intrinsicSize
    }
    
    /// 通用设置
    private func commom() {
        translatesAutoresizingMaskIntoConstraints = false
        setupUI()
    }
}

#endif
