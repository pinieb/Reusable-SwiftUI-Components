//
//  OutlinedFlatButtonStyle .swift
//  Reusable Swift UI Components
//
//  Created by Pete Biencourt on 6/22/19.
//  Copyright © 2019 piebie. All rights reserved.
//

import SwiftUI

/// Removes all style from a button
struct OutlinedFlatButtonStyle : ButtonStyle {
    struct Appearance {
        var borderColor = Color.black
        var borderWidth: Length = 1
        
        var contentVerticalPadding: Length = 5
        var contentHorizontalPadding: Length = 5
        
        var backgroundColor: Color = Color.clear
        
        var cornerRadius: Length = 8
    }
    
    /// The default appearance for the button
    var appearance: Appearance

    init(appearance: Appearance) {
        self.appearance = appearance
    }
    
    func body(configuration: Button<Self.Label>, isPressed: Bool) -> some View {
        #if os(macOS)
        return prepareBody(configuration: configuration, isPressed: isPressed)
        #else
        return prepareBody(configuration: configuration, isPressed: isPressed)
                .opacity(isPressed ? 0.4 : 1)
                .animation(.basic())
        #endif
    }
    
    private func prepareBody(configuration: Button<Self.Label>, isPressed: Bool) -> some View {
        return configuration.label
            .padding(.horizontal, appearance.contentHorizontalPadding)
            .padding(.vertical, appearance.contentVerticalPadding)
            .background(appearance.backgroundColor, cornerRadius: appearance.cornerRadius)
            .border(appearance.borderColor, width: appearance.borderWidth, cornerRadius: appearance.cornerRadius)
    }
}

extension StaticMember where Base : ButtonStyle {
    static func outlinedFlat(appearance: OutlinedFlatButtonStyle.Appearance = OutlinedFlatButtonStyle.Appearance()) -> OutlinedFlatButtonStyle.Member { return .init(.init(appearance: appearance)) }
}

#if DEBUG
struct OutlinedFlatButtonStyle_Previews : PreviewProvider {
    static var previews: some View {
        VStack {
            Button(action: {}) {
                Text("Outlined flat button style")
            }.buttonStyle(.outlinedFlat())

            Button(action: {}) {
                Text("Outlined flat button style")
                    .color(.white)
                    .font(.subheadline)
                }.buttonStyle(.outlinedFlat(appearance: OutlinedFlatButtonStyle.Appearance(borderColor: .purple, borderWidth: 4, contentVerticalPadding: 10, contentHorizontalPadding: 20, backgroundColor: .black, cornerRadius: 0)))
        }
    }
}
#endif
