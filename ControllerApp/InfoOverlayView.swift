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
                Text("Welcome to BlueSync!")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)

                VStack(alignment: .leading, spacing: 10) {
                    Text("🔵 Bluetooth Icon")
                        .bold()
                        .foregroundColor(.black)
                    Text("Tap this to connect to a Bluetooth device.")
                        .foregroundColor(.black)

                    Text("🕹️ Left & Right Joysticks")
                        .bold()
                        .foregroundColor(.black)
                    Text("Use the joysticks to control direction or motion.")
                        .foregroundColor(.black)

                    Text("🎚️ Sliders")
                        .bold()
                        .foregroundColor(.black)
                    Text("These can control analog input like throttle, light intensity, etc.")
                        .foregroundColor(.black)
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
                .foregroundColor(.white)
            Text(description)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}
