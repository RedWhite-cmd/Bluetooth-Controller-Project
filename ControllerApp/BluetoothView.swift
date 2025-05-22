//
//  BluetoothView.swift
//  ControllerApp
//
//  Created by Sudeep Thatiparthi on 5/4/25.
//

import SwiftUI
import CoreBluetooth

struct BluetoothView: View {
    @ObservedObject var btInterface = BTInterface.bluetooth
    @Environment(\.dismiss) var dismiss  // Used for dismissing the view manually

    var body: some View {
        VStack {
            // Top Bar with Back Button
            HStack {
                Button("← Back to Welcome") {
                    dismiss() // Cleanly pop the current view
                }
                .foregroundColor(.blue)

                Spacer()
            }
            .padding()
            .background(Color.white.shadow(radius: 2))

            // Bluetooth Devices List
            VStack {
                Text("Bluetooth Devices")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                if btInterface.peripheralsData.isEmpty {
                    Text("No devices found.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(btInterface.peripheralsData, id: \.identifier) { peripheral in
                            Button(action: {
                                connectToPeripheral(peripheral)
                            }) {
                                HStack {
                                    Text(peripheral.name ?? "Unknown Device")
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Circle()
                                        .fill(btInterface.service.connectionColor(peripheral: peripheral))
                                        .frame(width: 12, height: 12)
                                }
                            }
                        }
                    }
                }

                Button(action: {
                    btInterface.service.toggleScan()
                }) {
                    Text(btInterface.service.scState == .scanning ? "Stop Scanning" : "Start Scanning")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

            }
            .navigationTitle("Bluetooth")
            .navigationBarBackButtonHidden(true)
        }
    }

    func connectToPeripheral(_ peripheral: CBPeripheral) {
        btInterface.service.centralManager.connect(peripheral)
    }
}

#Preview {
    BluetoothView()
}

