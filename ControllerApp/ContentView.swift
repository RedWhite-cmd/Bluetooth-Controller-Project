//
//  ContentView.swift
//  ControllerApp
//
//  Created by Sudeep Thatiparthi on 3/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showGuide = true
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                gradient: Gradient(colors: [.blue.opacity(0.3), .purple.opacity(0.3)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack {
               
                HStack {
                    Spacer()
                    
                    Button("Back to Welcome") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Spacer()
                    
                    Button(action: {
                        showGuide = true
                    }) {
                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                            .padding()
                    }
                    
                    Spacer()
                }

                Spacer(minLength: 20)

                // Controls section
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .shadow(radius: 5)
                    .overlay(
                        HStack(spacing: 30) {
                            VStack(spacing: 8) {
                                Text("Joystick A").font(.caption)
                                JoystickView(xDataport: 15, yDataport: 14)
                            }

                            VStack(spacing: 8) {
                                Text("Slider A").font(.caption)
                                VerticalSlider(Dataport: 16)
                            }

                            VStack(spacing: 8) {
                                Text("Slider B").font(.caption)
                                VerticalSlider(Dataport: 17)
                            }

                            VStack(spacing: 8) {
                                Text("Joystick B").font(.caption)
                                JoystickView(xDataport: 13, yDataport: 15)
                            }
                        }
                        .padding()
                    )
                    .padding(.horizontal)
                    .frame(height: 280)

                Spacer()
            }
            Spacer()

            // Info overlay
            if showGuide {
                InfoOverlayView(isShowing: $showGuide)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentView()
}
