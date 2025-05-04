//
//  ContentView.swift
//  ControllerApp
//
//  Created by Sudeep Thatiparthi on 3/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showGuide = true
    @Environment(\.presentationMode) private var presentationMode // Used for manual navigation

    var body: some View {
        ZStack {
            Color(.systemBlue).ignoresSafeArea()

            NavigationView {
                VStack {
                    Spacer()

                    Button("Back to Welcome") {
                        presentationMode.wrappedValue.dismiss()  // This will dismiss the current view and go back to Welcome
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Spacer()

                    Button(action: {
                        showGuide = true
                    }) {
                        Image(systemName: "questionmark.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                            .padding(.top, 10)
                    }

                    Spacer()

                    HStack {
                        VStack { Spacer(); JoystickView(xDataport: 15, yDataport: 14) }
                        Spacer()
                        VStack { Spacer(); VerticalSlider(Dataport: 16) }
                        Spacer()
                        VStack { Spacer(); VerticalSlider(Dataport: 17) }
                        Spacer()
                        VStack { Spacer(); JoystickView(xDataport: 13, yDataport: 15) }
                    }
                    
                    Spacer()
                }
            }

            if showGuide {
                InfoOverlayView(isShowing: $showGuide)
            }
        }
        .navigationBarBackButtonHidden(true) // Hide the default back button
    }
}

#Preview {
    ContentView()
}
