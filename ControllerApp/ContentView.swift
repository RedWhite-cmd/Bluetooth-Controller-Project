//
//  ContentView.swift
//  ControllerApp
//
//  Created by Sudeep Thatiparthi on 3/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var goToBluetooth = false
    @State private var showGuide = true
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Spacer()
                    
                    Button(action: { goToBluetooth = true }) {
                        Image("Bluetooth")
                    }
                    .fullScreenCover(isPresented: $goToBluetooth){
                        BluetoothView()
                    }
                    
                    Spacer()
                    
                    HStack {
                        VStack{Spacer(); JoystickView(xDataport: 15,yDataport: 14)}
                        Spacer()
                        VStack{Spacer(); VerticalSlider()}
                        Spacer()
                        VStack{Spacer(); VerticalSlider()}
                        Spacer()
                        VStack{Spacer(); JoystickView(xDataport: 13,yDataport: 15)}
                    }
                }
                
                if showGuide {
                    InfoOverlayView(isShowing: $showGuide)
                }
                
            }
        }
    }
    
    
    struct BluetoothView: View {
        @State private var goToHome = false
        @ObservedObject var btInterface = BTInterface.bluetooth
        var body: some View {
            VStack {
                
                Button(action: { goToHome = true }) {
                    Image("User")
                }
                .fullScreenCover(isPresented: $goToHome){
                    ContentView()
                }
                
                Spacer()
                
                Button(action: {btInterface.service.toggleScan()}){
                    Text(btInterface.service.scState == .scanning ? "Stop Scan" : "Start Scan")
                }
                .padding()
                
                List(btInterface.peripheralsData, id: \.identifier) { peripheral in
                    HStack {
                        Text(peripheral.name ?? "Unknown")
                        
                        Spacer()
                        
                        Circle()
                            .fill(btInterface.service.connectionColor(peripheral: peripheral))
                            .frame(width: 10, height: 10)
                        
                        Button(action: {btInterface.service.centralManager.connect(peripheral, options: nil)}) {Text("Connect")}
                    }
                }
                
            }
            
            .navigationTitle("Bluetooth")
        }
    }
    
    
}
#Preview{
    ContentView()
}
