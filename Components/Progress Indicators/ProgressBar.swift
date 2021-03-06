//
//  ProgressBar.swift
//  Reusable Swift UI Components
//
//  Created by Pete Biencourt on 6/22/19.
//  Copyright © 2019 piebie. All rights reserved.
//

import SwiftUI

struct ProgressBar : View {
    
    var progress: Length
    
    var cornerRadius: Length = 4
    
    var panColor = Color.gray.opacity(0.5)
    var panBorderColor = Color.gray
    var panBorderWidth: Length = 1
    
    var fillColor = Color.blue
    
    var barHeight: Length = 5
    
    var body: some View {
        ZStack(alignment: .leading) {
        Rectangle()
            .frame(height: barHeight)
        .foregroundColor(panColor)
        .cornerRadius(cornerRadius, antialiased: true)
            .border(panBorderColor, width: panBorderWidth, cornerRadius: cornerRadius)

        
        Rectangle()
            .cornerRadius(cornerRadius, antialiased: true)
            .padding(panBorderWidth)
            .frame(height: barHeight)
            .foregroundColor(fillColor)
            
            .relativeWidth(getSafeProgress(progress))
            .animation(.basic(curve: .easeInOut))
            
        }
    }
    
    private func getSafeProgress(_ prog: Length) -> Length {
        if prog < 0 {
            return 0
        }
        
        if prog > 1 {
            return 1
        }
        
        return prog
    }
}

#if DEBUG

struct ProgressBar_Preview_View : View {
    @State var progress: Length = 0.5
    
    var body: some View {
        VStack(spacing: 50) {
            ProgressBar(progress: self.progress).frame(width: 300)
            
            ProgressBar(progress: self.progress, cornerRadius: 0, barHeight: 10)
                    .frame(width: 300)
            
            ProgressBar(progress: self.progress,  cornerRadius: 10, panColor: .green, panBorderColor: .purple, panBorderWidth: 3, fillColor: Color.white.opacity(0.9), barHeight: 20)
                .frame(width: 300)
            
            Button(action: { self.progress += 0.1 }) {
                Text("Add Progress")
            }
        }
    }
}

struct ProgressBar_Previews : PreviewProvider {
    static var previews: some View {
        GeometryReader { _ in
        VStack {
        ProgressBar_Preview_View()
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
#endif
