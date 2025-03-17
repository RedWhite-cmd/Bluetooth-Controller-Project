//
//  ContentView.swift
//  ControllerApp
//
//  Created by Sudeep Thatiparthi on 3/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var goToBluetooth = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some View {
        NavigationView {
            VStack {
                    Button(action: { goToBluetooth = true }) {
                        Image("Bluetooth")
                    }
                    .fullScreenCover(isPresented: $goToBluetooth){
                        BluetoothView()
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
                        
            Button(action: {if let firstCharacteristicFunction = btInterface.characteristicFunctionList.first {
                                firstCharacteristicFunction.sendData(string: "Button Clicked")
                            }
                        }) {
                            Text("Send Data on Button Click")
                        }
                    }

        .navigationTitle("Bluetooth")
    }
}


#Preview{
    ContentView()
}

