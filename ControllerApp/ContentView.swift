//
//  ContentView.swift
//  ControllerApp
//
//  Created by Sudeep Thatiparthi on 3/10/25.
//

import SwiftUI

struct ContentView: View {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: BluetoothView()) {
                    Button(action: {}) {
                        Image("Bluetooth")
                    }
                }
                
                Spacer()
                
                HStack {
                    JoystickView()
                    Spacer()
                    JoystickView()
                }
            }
            .navigationTitle("ControllerApp")
        }
    }
}

struct BluetoothView: View {
    var body: some View {
        VStack {
            Text("Bluetooth Screen")
                .font(.largeTitle)
                .padding()
            
            Spacer()
        }
        .navigationTitle("Bluetooth")
    }
}
#Preview{
    ContentView()
}
#Preview{
    BluetoothView()
}

