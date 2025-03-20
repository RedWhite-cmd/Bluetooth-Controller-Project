#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>

BLEServer *pServer = NULL;
bool deviceConnected = false;

#define SERVICE_UUID           "be5a512c-c0ca-43dd-8774-2d4dc27aeb47"  // UART service UUID
#define CHARACTERISTIC_UUID_RX "b0498ae6-f4cd-46ff-9809-097a2adfbfa8"

class MyServerCallbacks : public BLEServerCallbacks {
  void onConnect(BLEServer *pServer) {
    deviceConnected = true;
  };

  void onDisconnect(BLEServer *pServer) {
    deviceConnected = false;
  }
};

class MyCallbacks : public BLECharacteristicCallbacks {
  void onWrite(BLECharacteristic *pCharacteristic) {
    String arguement = pCharacteristic->getValue();

    if (arguement.length() > 0) {
      int port = arguement.substring(0,2).toInt();
      int value = arguement.substring(2,5).toInt();
      Serial.println(value);
      if (value >= 20) {
        digitalWrite(15, HIGH);
        delayMicroseconds(100); // Approximately 10% duty cycle @ 1KH
        digitalWrite(15, LOW);
        delayMicroseconds(1000 - 100);
      } else {
        digitalWrite(15, LOW);
        Serial.println("low");
      }
    }
  }
};

void setup() {
  Serial.begin(115200);
  pinMode(15, OUTPUT);

  // Create the BLE Device
  BLEDevice::init("Blue Sync Device");

  // Create the BLE Server
  pServer = BLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());

  // Create the BLE Service
  BLEService *pService = pServer->createService(SERVICE_UUID);

  // Create a BLE Characteristic
  BLECharacteristic *pRxCharacteristic = pService->createCharacteristic(CHARACTERISTIC_UUID_RX, BLECharacteristic::PROPERTY_WRITE);

  pRxCharacteristic->setCallbacks(new MyCallbacks());

  // Start the service
  pService->start();

  // Start advertising
  pServer->getAdvertising()->start();
  Serial.println("Waiting a client connection to notify...");
}

void loop() {
  
  // disconnecting
  if (!deviceConnected) {
    delay(500);                   // give the bluetooth stack the chance to get things ready
    pServer->startAdvertising();  // restart advertising
    Serial.println("start advertising");
  }
  // connecting
  if (deviceConnected) {

    // do stuff here on connecting
  }
}