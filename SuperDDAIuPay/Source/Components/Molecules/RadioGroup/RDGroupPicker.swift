//
//  RDGroupPicker.swift
//
//  Copyright © 2019 Yonat Sharon. All rights reserved.
//

#if canImport(SwiftUI)

import SweeterSwift
import SwiftUI

/// The missing iOS radio buttons group
@available(iOS 13.0, *) public struct RDGroupPicker: UIViewRepresentable {
    public typealias UIViewType = RDGroup
    private let uiView = RDGroup()

    @Binding var selectedIndex: Int

    public init(
        selectedIndex: Binding<Int>,
        titles: [String]? = nil,
        attributedTitles: [NSAttributedString]? = nil,
        selectedColor: UIColor? = nil,
        isVertical: Bool? = nil,
        buttonSize: CGFloat? = nil,
        spacing: CGFloat? = nil,
        itemSpacing: CGFloat? = nil,
        isButtonAfterTitle: Bool? = nil,
        titleColor: UIColor? = nil,
        titleAlignment: NSTextAlignment? = nil,
        titleFont: UIFont? = nil
    ) {
        _selectedIndex = selectedIndex
        uiView.titles =? titles
        uiView.attributedTitles =? attributedTitles
        uiView.selectedColor =? selectedColor
        uiView.isVertical =? isVertical
        uiView.buttonSize =? buttonSize
        uiView.spacing =? spacing
        uiView.itemSpacing =? itemSpacing
        uiView.isButtonAfterTitle =? isButtonAfterTitle
        uiView.titleColor =? titleColor
        uiView.titleAlignment =? titleAlignment
        uiView.titleFont =? titleFont
    }

    public func makeUIView(context: UIViewRepresentableContext<RDGroupPicker>) -> RDGroup {
        uiView.addTarget(context.coordinator, action: #selector(Coordinator.valueChanged), for: .valueChanged)
        return uiView
    }

    public func updateUIView(_ uiView: RDGroup, context: UIViewRepresentableContext<RDGroupPicker>) {
        uiView.selectedIndex = selectedIndex
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public class Coordinator: NSObject {
        let parent: RDGroupPicker

        init(_ parent: RDGroupPicker) {
            self.parent = parent
        }

        @objc func valueChanged(_ sender: RDGroup) {
            parent.selectedIndex = sender.selectedIndex
        }
    }
}

@available(iOS 13.0, *) public extension RDGroupPicker {
    func buttonSize(_ buttonSize: CGFloat) -> Self {
        uiView.buttonSize = buttonSize
        return self
    }

    func isButtonAfterTitle(_ isButtonAfterTitle: Bool) -> Self {
        uiView.isButtonAfterTitle = isButtonAfterTitle
        return self
    }

    func isVertical(_ isVertical: Bool) -> Self {
        uiView.isVertical = isVertical
        return self
    }

    func itemSpacing(_ itemSpacing: CGFloat) -> Self {
        uiView.itemSpacing = itemSpacing
        return self
    }

    func selectedColor(_ selectedColor: UIColor) -> Self {
        uiView.selectedColor = selectedColor
        return self
    }

    func spacing(_ spacing: CGFloat) -> Self {
        uiView.spacing = spacing
        return self
    }

    func titleAlignment(_ titleAlignment: NSTextAlignment) -> Self {
        uiView.titleAlignment = titleAlignment
        return self
    }

    func titleColor(_ titleColor: UIColor) -> Self {
        uiView.titleColor = titleColor
        return self
    }

    func titleFont(_ titleFont: UIFont) -> Self {
        uiView.titleFont = titleFont
        return self
    }
}

#endif
