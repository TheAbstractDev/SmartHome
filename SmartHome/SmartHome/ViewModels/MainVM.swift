//
//  MainViewModel.swift
//  SmartHome
//
//  Created by Sofiane Beors on 02/06/2023.
//

import Foundation

final class MainViewModel: ObservableObject {
    @Published var powerUsage = 20.3
    @Published var user = User(firstname: "Alex", lastname: "Tobey", imageName: "user")
    @Published var rooms = [Room]()
    
    func getRooms() {
        var devices = [Device]()
        devices.append(Device(id: 0, name: "Heater", imageName: "heater.vertical"))
        devices.append(Device(id: 1, name: "Music", imageName: "music.note"))
        devices.append(Device(id: 2, name: "Fan", imageName: "fanblades"))
        devices.append(Device(id: 3, name: "Light", imageName: "lightbulb"))
        devices.append(Device(id: 4, name: "Outlet", imageName: "poweroutlet.type.e"))
        
        self.rooms.append(Room(id: 0, name: "Bedroom", imageName: "bed.double.fill", devices: Array(arrayLiteral: devices.first!)))
        self.rooms.append(Room(id: 1, name: "Living Room", imageName: "sofa.fill", devices: devices))
        self.rooms.append(Room(id: 2, name: "Kitchen", imageName: "sink.fill", devices: Array(devices[0...2])))
        self.rooms.append(Room(id: 3, name: "Office", imageName: "desktopcomputer", devices: Array(devices[0...1])))
    }
}
