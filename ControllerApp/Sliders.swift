//
//  Sliders.swift
//  ControllerApp
//
//  Created by Sudeep Thatiparthi on 3/19/25.
//

import SwiftUI

struct VerticalSlider: View {
    @State private var sliderValue: Double = 0.0 // Start at bottom (0)

    var body: some View {
        VStack {
            Text("Value: \(Int(sliderValue))") // Display value
            
            ZStack(alignment: .bottom) { // Align from bottom
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 50, height: 200) // Vertical slider track
                    .foregroundColor(Color.gray.opacity(0.3))

                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 50, height: CGFloat(sliderValue * 2)) // Dynamic height
                    .foregroundColor(.blue)
                    .animation(.easeInOut, value: sliderValue)
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let newValue = min(max(0, (200 - value.location.y) / 2), 100) // Invert Y mapping
                        sliderValue = newValue
                    }
            )
        }
        .padding()
    }
}


