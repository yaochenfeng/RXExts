//
//  Reactive+obj.swift
//  RXExts
//
//  Created by yaochenfeng on 2022/10/27.
//

import Foundation

public extension Reactive where Base: AnyObject {
    /// 链式操作
    @discardableResult func then(_ block: (Base) throws -> Void) rethrows -> Base {
        try block(self.base)
        return self.base
    }
    /// 链式语法
    subscript<Value>(dynamicMember keyPath: WritableKeyPath<Base, Value>) -> ((Value) -> Reactive<Base>) {
        // 获取到真正的对象
        var subject = self.base
        return { value in
            subject[keyPath: keyPath] = value
            return self
        }
    }
    /// 链式响应语法
    subscript<Value>(dynamicMember keyPath: WritableKeyPath<Base, Value>) -> ((Observable<Value>) -> Reactive<Base>) {
        return { value in
            value.subscribe(onNext: { [weak base] newValue in
                base?[keyPath: keyPath] = newValue
            }).disposed(by: disposeBag)
            return self
        }
    }
    /// 资源释放
    var disposeBag: DisposeBag {
        synchronizedBag {
            if let disposeObject = objc_getAssociatedObject(base, &AssociatedKeys.dispose) as? DisposeBag {
                return disposeObject
            }
            let disposeObject = DisposeBag()
            objc_setAssociatedObject(base, &AssociatedKeys.dispose, disposeObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return disposeObject
        }
    }
    /// 链式语法调用函数
    @discardableResult func chain(_ block: (Base) throws -> Void) rethrows -> Reactive<Base> {
        try block(base)
        return self
    }
    /// 同步调用
    @discardableResult func synchronizedBag<T>( _ action: () -> T) -> T {
        objc_sync_enter(self.base)
        let result = action()
        objc_sync_exit(self.base)
        return result
    }
}
