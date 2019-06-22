//
//  PlainButtonStyle.swift
//  Reusable Swift UI Components
//
//  Created by Pete Biencourt on 6/22/19.
//  Copyright © 2019 piebie. All rights reserved.
//

import SwiftUI

/// Removes all style from a button
struct PlainButtonStyle: ButtonStyle {
    func body(configuration: Button<Self.Label>, isPressed: Bool) -> some View {
        configuration.label
    }
}

extension StaticMember where Base: ButtonStyle {
    static var plain: PlainButtonStyle.Member { return .init(.init()) }
}

#if DEBUG
struct PlainButtonStyle_Previews : PreviewProvider {
    static var previews: some View {
        Button(action: {}) {
            Text("Plain Button")
        }.buttonStyle(.plain)
    }
}
#endif
