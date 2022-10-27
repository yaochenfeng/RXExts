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
}

#endif
