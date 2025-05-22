//
//  InfoOverlayView.swift
//  ControllerApp
//
//  Created by Sudeep Thatiparthi on 4/14/25.
//

import SwiftUI


struct InfoOverlayView: View {
    @Binding var isShowing: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    isShowing = false
                }

            VStack(spacing: 20) {
                Text("Welcome to Basic Controls")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)

                VStack(alignment: .leading, spacing: 10) {
                    Group {

                        Text("🕹️Right Joysticks").bold().foregroundColor(.black)
                        Text("Use these to control direction or motion.").foregroundColor(.black)
                        
                        Text("🕹️Left Joysticks").bold().foregroundColor(.black)
                        Text("Use these to control direction or motion.").foregroundColor(.black)

                        Text("🎚️ Sliders").bold().foregroundColor(.black)
                        Text("These control analog input like throttle or light intensity.").foregroundColor(.black)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Button("Got it!") {
                    isShowing = false
                }
                .padding()
                .background(Color.white)
                .foregroundColor(.blue)
                .cornerRadius(10)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .padding()
        }
    }
}



struct GuideStepView: View {
    let title: String
    let description: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black) // Changed to black
            Text(description)
                .font(.subheadline)
                .foregroundColor(.black.opacity(0.8)) // Changed to black
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var isShowing = true
        
        var body: some View {
            InfoOverlayView(isShowing: $isShowing)
        }
    }

    return PreviewWrapper()
}

