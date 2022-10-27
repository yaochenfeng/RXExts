//
//  Reactive+View.swift
//  RXExts
//
//  Created by yaochenfeng on 2022/10/27.
//


#if canImport(SwiftUI)
import SwiftUI
import UIKit

@available(iOS 13.0, *)
extension Reactive: View where Base: UIView {}
@available(iOS 13.0, *)
extension Reactive: UIViewRepresentable where Base: UIView {
    public func makeUIView(context: Context) -> Base {
        return base
    }
    public func updateUIView(_ uiView: Base, context: Context) {}
    public typealias UIViewType = Base
}
#endif
