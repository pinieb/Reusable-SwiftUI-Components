//
//  OutlinedFlatButton.swift
//  Reusable Swift UI Components
//
//  Created by Pete Biencourt on 6/22/19.
//  Copyright © 2019 piebie. All rights reserved.
//

import SwiftUI

/// A button that has an outline and a flat appearance
/// Note: This button can only have a `Text` label
struct OutlinedFlatButton : View {
    struct Appearance {
        var borderColor = Color.black
        var borderWidth: Length = 1
        
        var textColor = Color.black
        var font = Font.body
        var textVerticalPadding: Length = 5
        var textHorizontalPadding: Length = 5
        
        var backgroundColor: Color = Color.clear
        
        var cornerRadius: Length = 8
    }
    
    var action: () -> Void
    var label: Text
    
    /// The default appearance for the button
    var normalAppearance: Appearance
    
    #if os(macOS)
    /// The appearance for the button while being hovered
    /// Note: Hover is only supported on macOS
    var hoverAppearance: Appearance
    #endif
    
    @State var isHovering: Bool = false
    private var currentAppearance: Appearance {
        #if os(macOS)
        return isHovering ? hoverAppearance : normalAppearance
        #else
        return appearance
        #endif
    }
    
    #if os(macOS)
    init(action: @escaping () -> Void, normalAppearance: Appearance = Appearance(), hoverAppearance: Appearance? = nil, label: () -> Text) {
        
        self.action = action
        self.label = label()
        
        self.normalAppearance = normalAppearance
        
        if let hoverAppearance = hoverAppearance {
            self.hoverAppearance = hoverAppearance
        } else {
            self.hoverAppearance = normalAppearance
        }
    }
    #else
    init(action: @escaping () -> Void, appearance: Appearance = Appearance(), label: () -> Text) {
        
        self.action = action
        self.label = label()
        
        self.appearance = appearance
    }
    #endif
    
    var body: some View {
        Button(action: action) {
            label
                .color(currentAppearance.textColor)
                .font(currentAppearance.font)
            }
            .buttonStyle(.plain)
            .padding(.horizontal, currentAppearance.textHorizontalPadding)
            .padding(.vertical, currentAppearance.textVerticalPadding)
            .background(currentAppearance.backgroundColor, cornerRadius: currentAppearance.cornerRadius)
            .border(currentAppearance.borderColor, width: currentAppearance.borderWidth, cornerRadius: currentAppearance.cornerRadius)
//        #if os(macOS)
//            .onHover(perform: { hovering in self.isHovering = hovering })
//        #endif
    }
}

#if DEBUG
struct OutlinedFlatButton_Previews : PreviewProvider {
    static var previews: some View {
        VStack {
        OutlinedFlatButton(action: {}) {
            Text("Outlined Flat Button")
        }
        
        Button(action: {}) {
            Text("Button")
        }
        }
    }
}
#endif
