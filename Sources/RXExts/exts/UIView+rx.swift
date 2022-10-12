#if canImport(UIKit)

import UIKit

public extension Reactive where Base: NSObject {
    /// 创建对象链式操作
    static var new: Reactive<Base> {
        return Base().rx
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
}
public extension Reactive where Base: UICollectionView {
    static var new: Reactive<Base> {
        let layout = UICollectionViewFlowLayout()
        return Base(frame: .zero, collectionViewLayout: layout).rx
    }
}
#endif
