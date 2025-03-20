//
//  JoystickView.swift
//  ControllerApp
//
//  Created by Sudeep Thatiparthi on 3/10/25.
//

import SwiftUI

struct JoystickView: View {
    @State private var dragOffset: CGSize = .zero
    
    let maxRadius: CGFloat = 50  // Maximum movement distance
    
    var body: some View {
        ZStack {
            // Joystick base
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 150, height: 150)
            
            // Joystick knob
            Circle()
                .fill(Color.red)
                .frame(width: 100, height: 100)
                .offset(dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let distance = sqrt(value.translation.width * value.translation.width +
                                                value.translation.height * value.translation.height)
                            
                            // Restrict movement within maxRadius
                            if distance <= maxRadius {
                                dragOffset = value.translation
                                BTInterface.bluetooth.characteristicFunctionList.first?.sendData(string: "15\(dragOffset.height)")
                                print(dragOffset.height)
                            } else {
                                let angle = atan2(value.translation.height, value.translation.width)
                                dragOffset = CGSize(width: cos(angle) * maxRadius, height: sin(angle) * maxRadius)
                            }
                        }
                        .onEnded { _ in
                            // Animate return to center
                            withAnimation(.spring()) {
                                dragOffset = .zero
                            }
                        }
                )
        }
    }
}
