//
//  Room.swift
//  SmartHome
//
//  Created by Sofiane Beors on 16/09/2023.
//

import Foundation

struct Room {
    var id: Int
    var name: String
    var imageName: String
    var devices: [Device]
    
    init(id: Int, name: String, imageName: String, devices: [Device]) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.devices = devices
    }
}
