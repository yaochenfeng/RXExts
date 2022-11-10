//
//  UIViewController+rx.swift
//  RXExts
//
//  Created by yaochenfeng on 2022/10/27.
//
#if canImport(UIKit)
import UIKit


public extension Reactive where Base: UIViewController {
    /// launch vc
    static var launch: UIViewController? {
        guard let name = Bundle.main.infoDictionary?["UILaunchStoryboardName"] as? String else { return nil }
        return UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()
    }
    /// 附加安全边距
    var additionalSafeAreaInsets: UIEdgeInsets {
        set {
            if #available(iOS 11.0, *) {
                base.additionalSafeAreaInsets = newValue
            } else {
                objc_setAssociatedObject(base, &AssociatedKeys.safeAreaInsets, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                base.view.rx.safeAreaLayoutGuide.snp.remakeConstraints { make in
                    make.top.equalTo(base.topLayoutGuide.snp.bottom).offset(newValue.top)
                    make.left.equalTo(base.view).offset(newValue.left)
                    make.right.equalTo(base.view).offset(-newValue.right)
                    make.bottom.equalTo(base.bottomLayoutGuide.snp.top).offset(-newValue.bottom)
                }
            }
        }
        get {
            if #available(iOS 11.0, *) {
                return base.additionalSafeAreaInsets
            }
            if let obj = objc_getAssociatedObject(base, &AssociatedKeys.safeAreaInsets) as? UIEdgeInsets {
                return obj
            }
            return .zero
        }
    }
}

#endif
