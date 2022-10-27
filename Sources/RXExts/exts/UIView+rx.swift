#if canImport(UIKit)

import UIKit

public extension Reactive where Base: NSObject {
    /// 创建对象链式操作
    static var new: Reactive<Base> {
        return Base().rx
    }
}
public extension Reactive where Base: UIView {
    
    var safeAreaLayoutGuide: UILayoutGuide {
        if #available(iOS 11.0, *) {
            return base.safeAreaLayoutGuide
        }
        if let obj = objc_getAssociatedObject(base, &AssociatedKeys.layoutGuide) as? UILayoutGuide {
            return obj
        }
        return UILayoutGuide.rx.new.chain { guide in
            base.addLayoutGuide(guide)
            objc_setAssociatedObject(base, &AssociatedKeys.layoutGuide, guide, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            guide.snp.makeConstraints { mk in
                mk.leading.trailing.equalTo(base)
                if let vc = base.next as? UIViewController {
                    mk.top.equalTo(vc.topLayoutGuide.snp.bottom)
                    mk.bottom.equalTo(vc.bottomLayoutGuide.snp.top)
                } else {
                    mk.top.bottom.equalTo(base)
                }
            }
        }.base
    }
}

public extension Reactive where Base: UIView {
    /// 创建对象链式操作
    static var new: Reactive<Base> {
        return Base(frame: .zero).rx
    }
    /// 根据视图找到对应的控制器
    var controller: UIViewController? {
        for view in sequence(first: base.superview, next: { $0?.superview }) {
            if let responder = view?.next, responder.isKind(of: UIViewController.self) {
                return responder as? UIViewController
            }
        }
        return nil
    }
    /// 根据视图找到对应nav
    var navigationController: UINavigationController? {
        for view in sequence(first: base.superview, next: { $0?.superview }) {
            if let responder = view?.next, responder.isKind(of: UIViewController.self) {
                return responder as? UINavigationController
            }
        }
        return nil
    }
    /// 设置圆角弧度
    @discardableResult
    func cornerRadius(_ radius: CGFloat) -> Self {
        base.layer.cornerRadius = radius
        base.layer.masksToBounds = true
        return self
    }
    /// 获取对应值
    @discardableResult func ref(_ ref: inout Base?) -> Self {
        ref = base
        return self
    }
}
public extension Reactive where Base: UICollectionView {
    static var new: Reactive<Base> {
        let layout = UICollectionViewFlowLayout()
        return Base(frame: .zero, collectionViewLayout: layout).rx
    }
}
#endif
