#if canImport(UIKit) && canImport(SnapKit)
import UIKit
import SnapKit
public typealias ConstraintMaker = SnapKit.ConstraintMaker

/// 使用snp处理布局
public extension Reactive where Base: UIView {
    var snp: ConstraintViewDSL {
        return base.snp
    }
    
    /// 添加到父视图
    /// - Parameter sp: 父视图
    /// - Returns: Reactive
    @discardableResult func add2(_ sp: UIView) -> Self {
        sp.addSubview(base)
        return self
    }
    /// snapkit make布局
    /// - Parameter mk: 布局描述
    /// - Returns: 自身(for chainable)
    @discardableResult
    func lyt(_ mk: (ConstraintMaker)->Void) -> Self {
        base.snp.makeConstraints(mk)
        return self
    }
    
    /// snapkit remake布局
    /// - Parameter mk: 布局描述
    /// - Returns: 自身(for chainable)
    @discardableResult
    func relyt(_ mk: (ConstraintMaker)->Void) -> Self {
        base.snp.remakeConstraints(mk)
        return self
    }
    
    /// snapkit update布局
    /// - Parameter mk: 布局描述
    /// - Returns: 自身(for chainable)
    @discardableResult
    func uplyt(_ mk: (ConstraintMaker)->Void) -> Self {
        base.snp.updateConstraints(mk)
        return self
    }
    
    /// snapkit remove布局
    /// - Returns: 自身(for chainable)
    @discardableResult
    func rmlyt() -> Self {
        base.snp.removeConstraints()
        return self
    }
    
    @discardableResult func frame(width: CGFloat? = nil, height: CGFloat? = nil) -> Self {
        return relyt { mk in
            if let width = width {
                mk.width.equalTo(width).priority(.high)
            }
            if let height = height {
                mk.height.equalTo(height).priority(.high)
            }
        }
    }
    @discardableResult func frame(
        minWidth: CGFloat? = nil,
        idealWidth: CGFloat? = nil,
        maxWidth: CGFloat? = nil,
        minHeight: CGFloat? = nil,
        idealHeight: CGFloat? = nil,
        maxHeight: CGFloat? = nil
    ) -> Self {
        return frame(width: idealWidth, height: idealHeight).relyt { mk in
            if let minWidth = minWidth {
                mk.width.greaterThanOrEqualTo(minWidth)
            }
            if let maxWidth = maxWidth {
                mk.width.lessThanOrEqualTo(maxWidth)
            }
            if let minHeight = minHeight {
                mk.height.greaterThanOrEqualTo(minHeight)
            }
            if let maxHeight = maxHeight {
                mk.height.lessThanOrEqualTo(maxHeight)
            }
        }
    }
    @discardableResult func layoutPriority(
        _ value: UILayoutPriority = .fittingSizeLevel,
        axis: NSLayoutConstraint.Axis = .horizontal) -> Self {
            return chain { base in
                base.setContentHuggingPriority(value, for: axis)
                base.setContentCompressionResistancePriority(value, for: axis)
            }
        }
}
#endif
