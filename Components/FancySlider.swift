//
//  FancySlider.swift
//  Reusable SwiftUI Components
//
//  Created by Pete Biencourt on 7/1/19.
//  Copyright © 2019 piebie. All rights reserved.
//

import SwiftUI

struct FancySlider : View {
    
    @State var minValue = Length(0)
    @State var maxValue = Length(100)
    
    @State var currentValue = Length(50)
    
    @State var smallCircleOffset = Length(0)
    @State var largeCircleOffset = Length(0)
    
    @State var barWidth = Length(100)
    
    @State var allowsAnimation = false
    @State var isDragging = false
    @State var isAnimating = false
    
    var animation: Animation = .basic(duration: 10, curve: .easeInOut)

    var body: some View {
        VStack {
            
            HStack {
                Text(String(format: "%.0f", smallCircleOffset))//minValue))
                Spacer()
                Text(String(format: "%.0f", largeCircleOffset))//maxValue))
            }
            
            ZStack(alignment: .leading) {
                
                Rectangle()
                    .frame(height: 7)
                    .foregroundColor(.black)
                    .cornerRadius(4, antialiased: true)
                    .background(BarGeometry())
                    .onPreferenceChange(WidthPreferenceKey.self, perform: { self.barWidth = $0 })
                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onChanged({ g in
                        self.allowsAnimation = false
                        self.isDragging = true
                        self.largeCircleOffset = min(max(g.location.x, 0), self.barWidth)
                    }).onEnded({ _ in
                        self.allowsAnimation = true
                        self.isDragging = false
                        self.smallCircleOffset = self.largeCircleOffset
                    }))
                
                Circle()
                    .inset(by: 1)
                    .fill(Color.white)
                    .frame(width: 10, height: 10)
                    .offset(x: smallCircleOffset - 5)
                    .animation(allowsAnimation ? animation : nil)
                    .allowsHitTesting(false)
                
                if isDragging {
                    Circle()
                        .stroke(Color.white, lineWidth: 1)
                        .frame(width: 30, height: 30)
                        .offset(x: largeCircleOffset - 15)
                        .allowsHitTesting(false)
                }
                
//                Rectangle()
//                    .frame(width: abs(smallCircleOffset - largeCircleOffset), height: 1)
//                    .foregroundColor(.white)
//                    .cornerRadius(1, antialiased: true)
//                    .offset(x: min(smallCircleOffset, largeCircleOffset))
//                    .animation(allowsAnimation ? animation : nil)
                
                ConnectingBar(pointA: $smallCircleOffset, pointB: $largeCircleOffset)
                    .animation(allowsAnimation ? animation : nil)
                    .offset(x: smallCircleOffset < largeCircleOffset ? smallCircleOffset : largeCircleOffset)
            }.frame(height: 30)
        }
    }
}

struct ConnectingBar: View {
    
    @Binding var pointA: Length
    @Binding var pointB: Length
    
    var width: Length {
        return pointA - pointB
    }
    
    var body: some View {
        Rectangle()
            .frame(width: abs(width), height: 1)
            //.animation(.basic(duration: 5))
            .foregroundColor(.white)
            .cornerRadius(1, antialiased: true)
            //.offset(x: width > 0 ? pointB : pointA)
    }
}

struct WidthPreferenceKey: PreferenceKey {
    static var defaultValue = CGFloat(0)
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
    
    typealias Value = CGFloat
}

struct BarGeometry: View {
    var body: some View {
        GeometryReader { geometry in
            return Rectangle().preference(key: WidthPreferenceKey.self, value: geometry.size.width)
        }
    }
}

//@available(iOS 13.0, OSX 10.15, watchOS 6.0, *)
//@available(tvOS, unavailable)
//extension Slider {
//
//    /// Creates an instance that selects a value in the range
//    /// `minValue...maxValue`.
//    ///
//    /// - Parameters:
//    ///     - value: The selected value within `minValue...maxValue`. The
//    ///       `value` of the created instance will be equal to the position of
//    ///       the given value within `minValue...maxValue` mapped into `0...1`.
//    ///
//    ///     - minValue: The beginning of the range of the valid values. Defaults
//    ///       to `0.0`
//    ///
//    ///     - maxValue: The end of the range of valid values. Defaults to `1.0`.
//    @available(tvOS, unavailable)
//    public init<V>(value: Binding<V>, from minValue: V = 0.0, through maxValue: V = 1.0, onEditingChanged: @escaping (Bool) -> Void = { _ in }) where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint
//
//    /// Creates an instance that selects a value in the range
//    /// `minValue...maxValue`.
//    ///
//    /// - Parameters:
//    ///     - value: The selected value within `minValue...maxValue`. The
//    ///       `value` of the created instance will be equal to the position of
//    ///       the given value within `minValue...maxValue` mapped into `0...1`.
//    ///
//    ///     - minValue: The beginning of the range of the valid values.
//    ///
//    ///     - maxValue: The end of the range of valid values. `maxValue` is a
//    ///       valid value if and only if it can be produced from `minValue`
//    ///       using multiples of `stride`.
//    ///
//    ///     - stride: The distance between each valid value. A positive `stride`
//    ///       moves upward; a negative `stride` moves downward. `stride` is
//    ///       required to move towards `maxValue`.
//    @available(tvOS, unavailable)
//    public init<V>(value: Binding<V>, from minValue: V, through maxValue: V, by stride: V.Stride, onEditingChanged: @escaping (Bool) -> Void = { _ in }) where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint
//}



#if DEBUG
struct FancySlider_Previews : PreviewProvider {
    static var previews: some View {
        FancySlider().frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
#endif
