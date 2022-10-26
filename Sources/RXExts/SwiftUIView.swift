//
//  SwiftUIView.swift
//  RXExts
//
//  Created by yaochenfeng on 2022/10/26.
//
#if canImport(SwiftUI)
import SwiftUI

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
