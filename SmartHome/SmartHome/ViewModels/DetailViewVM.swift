//
//  DetailViewVM.swift
//  SmartHome
//
//  Created by Sofiane Beors on 02/06/2023.
//

import Foundation

final class DetailVM: ObservableObject {
    @Published var currentTemperature = 16.5
    @Published var setTemperature = 18.5
    @Published var currentHumidity = 60.0
    @Published var devices = [Device]()
    @Published var records = [Record]()
    
    func getDevices() {
        devices.append(Device(id: 0, name: "Heater", imageName: "heater.vertical"))
        devices.append(Device(id: 1, name: "Music", imageName: "music.note"))
        devices.append(Device(id: 2, name: "Fan", imageName: "fanblades"))
        devices.append(Device(id: 3, name: "Light", imageName: "lightbulb"))
        devices.append(Device(id: 4, name: "Outlet", imageName: "poweroutlet.type.e"))
    }
    
    @MainActor
    func getRecords() async {
        records.append(Record(id: 0, temperature: currentTemperature, humidity: currentHumidity, date: .now, animate: false))
        
        for i in 1...30 {
            records.append(Record(id: i, temperature: Double.random(in: 13.0...26.5), humidity: Double.random(in: 50.0...75.0), date: Date().dayBefore(nb: i), animate: false))
        }
    }
}

extension Date {
    func dayBefore(nb: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: nb, to: self)!
    }
}
