#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Toggle AirPods
// @raycast.mode silent
// @raycast.packageName Audio
//
// Optional parameters:
// @raycast.icon images/airpods-pro.png
//
// Documentation:
// @raycast.description Toggle my Airpods Pro
// @raycast.author albertilagan
// @raycast.authorURL https://raycast.com/albertilagan

import IOBluetooth

// Get your device's MAC address by option (⌥) + clicking the bluetooth icon in the menu bar
let deviceAddress = "68:3E:C0:C0:8E:BA"

func toggleAirPods() {
    guard let bluetoothDevice = IOBluetoothDevice(addressString: deviceAddress) else {
        print("Device not found")
        exit(1)
    }

    if !bluetoothDevice.isPaired() {
        print("Device not paired")
        exit(1)
    }

    if bluetoothDevice.isConnected() {
        print("AirPods Disconnected")
        bluetoothDevice.closeConnection()
    } else {
        print("AirPods Connected")
        bluetoothDevice.openConnection()
    }
}

toggleAirPods()
