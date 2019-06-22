//
//  OutlineFlatButtonWithHover.swift
//  Reusable Swift UI Components for Mac
//
//  Created by Pete Biencourt on 6/22/19.
//  Copyright © 2019 piebie. All rights reserved.
//

import SwiftUI

struct OutlineFlatButtonWithHover<Label> : View where Label : View {
    var action: () -> Void
    var label: Label
    
    /// The default appearance for the button
    var normalAppearance: OutlinedFlatButtonStyle.Appearance
    
    /// The appearance for the button while being hovered
    var hoverAppearance: OutlinedFlatButtonStyle.Appearance
    
    @State var isHovering: Bool = false
    
    init(action: @escaping () -> Void, normalAppearance: OutlinedFlatButtonStyle.Appearance = OutlinedFlatButtonStyle.Appearance(), hoverAppearance: OutlinedFlatButtonStyle.Appearance, label: () -> Label) {
        self.action = action
        self.label = label()
        
        self.normalAppearance = normalAppearance
        self.hoverAppearance = hoverAppearance
    }
    
    var body: some View {
        let appearance = isHovering ? hoverAppearance : normalAppearance
        
        return Button(action: action) {
            label
            }
            .buttonStyle(.plain)
                .padding(.horizontal, appearance.contentHorizontalPadding)
                .padding(.vertical, appearance.contentVerticalPadding)
            .background(appearance.backgroundColor, cornerRadius: appearance.cornerRadius)
            .border(appearance.borderColor, width: appearance.borderWidth, cornerRadius: appearance.cornerRadius)
            .onHover(perform: { hovering in self.isHovering = hovering })
    }
}

#if DEBUG
struct OutlineFlatButtonWithHover_Previews : PreviewProvider {
    static var previews: some View {
        let appearance = OutlinedFlatButtonStyle.Appearance(backgroundColor: Color.black.opacity(0.2))
        
        return OutlineFlatButtonWithHover(action: {}, hoverAppearance: appearance) {
            Text("Outline flat button with hover")
        }
    }
}
#endif
