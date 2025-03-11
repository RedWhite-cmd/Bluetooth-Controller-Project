//
//  BlueTooth.swift
//  Bluetooth
//
//  Created by Paul O'Connell on 2/27/25.
//
import CoreBluetooth
import SwiftUI
import os




class BTInterface: ObservableObject {
    static var bluetooth: BTInterface = BTInterface.init()
    @Published var peripheralsData: [CBPeripheral] = [] //array that holds all peripherals scanned for
    @Published var characteristicFunctionList: [CharacteristicFunction] = [] //makes characteristics function array
    @Published var service: BluetoothService = BluetoothService.init()  //instance of bluetooth service
    private init() {
        
    }
}
@Observable
class BluetoothService: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    //constructer
    public override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    func setBluetoothService(referenceToInterface: BTInterface) {
        BTInterface.bluetooth = referenceToInterface
    }
    enum ScannerState { //makes a enum about color states
        case scanning, disconnected, error, found
        var color: Color {
            switch self {
            case .scanning:
                    .green
            case .disconnected:
                    .purple
            case .error:
                    .red
            case .found:
                    .yellow
            }
        }
    }
    var centralManager: CBCentralManager! // central manger variable created
    var scState: ScannerState = .disconnected //default state
    var servicesWanted: [CBUUID] = [CBUUID(string: "be5a512c-c0ca-43dd-8774-2d4dc27aeb47")]
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("central.state is .unknown")
        case .resetting:
            print("central.state is .resetting")
        case .unsupported:
            print("central.state is .unsupported")
        case .unauthorized:
            print("central.state is .unauthorized")
        case .poweredOff:
            print("central.state is .poweredOff")
        case .poweredOn:
            print("central.state is .poweredOn")
        @unknown default:
            fatalError()
        } //switch about central manager possible states
    }
    //did Discover a Peripheral
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        scState = .found //found the peripheral and updates state
        
        peripheral.delegate = BluetoothService.Peripheralmanager.shared //adds delegate
        //add checks wether device was checked
        if !peripheral.description.contains("(null)") {//removes devices which don't have names
            var currentInstance:Int = 0, finalInstance:Int = BTInterface.bluetooth.peripheralsData.count //setup range of the loop
            if finalInstance != 0 {
                while (currentInstance <= finalInstance) {
                    if peripheral == BTInterface.bluetooth.peripheralsData[currentInstance] { //checks wether or not the the peripheral is in the list and will break if it
                        break
                    } else if currentInstance == finalInstance - 1 {
                        print(peripheral) //data on peripheral
                        BTInterface.bluetooth.peripheralsData.append(peripheral)
                    }
                    currentInstance += 1
                }
            } else {
               print(peripheral) //data on peripheral
                BTInterface.bluetooth.peripheralsData.append(peripheral)
            }
        }
        scState = .scanning
    }
    
    //did connect and discovers services
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("connected")
        peripheral.discoverServices(servicesWanted) //Discover Services
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: (any Error)?) {
        scState = .error
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, timestamp: CFAbsoluteTime, isReconnecting: Bool, error: (any Error)?) {
        print("disconnected")
        scState = .disconnected
    }
    func toggleScan() {
        if (scState == .scanning) {
            centralManager.stopScan() //stop scanning
            scState = .disconnected
        } else {
            centralManager.scanForPeripherals(withServices: nil) //start scanning
            scState = .scanning
        }
    }
    func connectionColor(peripheral: CBPeripheral) -> Color {//correlate colors and states
        switch peripheral.state {
        case .connected:
            return Color.green
        case .disconnected:
            return Color.gray
        case .connecting:
            return Color.yellow
        case .disconnecting:
            return Color.yellow
        @unknown default:
            return Color.red
        }
    }
    class Peripheralmanager: NSObject, CBPeripheralDelegate {
        static let shared = Peripheralmanager()
        //constructor
        override init() { super.init()}
        func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: (any Error)?) {
            guard let services = peripheral.services else { return } //saves array of services
            for service in services {//prints and discovers characteristics of service
                print(service)
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
        func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService,
                        error: Error?) {
            guard let characteristics = service.characteristics else { return } //saves characteristics
            for characteristic in characteristics {
                print(characteristic) //prints the characteristics
                BTInterface.bluetooth.characteristicFunctionList.append(CharacteristicFunction.init(peripheral: peripheral, characteristic: characteristic))
            }
        }
        func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: (any Error)?) {
            if let error {
                print("error")
            } else {
                print("Characteristic wrote")
            }
        }
    }
}
class CharacteristicFunction {
    private let peripheral: CBPeripheral;
    private let characteristic: CBCharacteristic;
    init(peripheral: CBPeripheral, characteristic: CBCharacteristic) {
        self.peripheral = peripheral
        self.characteristic = characteristic
    }
    func sendData(string: String) {
        peripheral.writeValue(string.data(using: .utf8)!, for: characteristic, type: .withResponse)
    }
    func getPeripheral() -> CBPeripheral {
        return peripheral
    }
    func getCharacteristic() -> CBCharacteristic {
        return characteristic
    }
}
