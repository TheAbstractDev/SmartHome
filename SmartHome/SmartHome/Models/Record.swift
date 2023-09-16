//
//  Record.swift
//  SmartHome
//
//  Created by Sofiane Beors on 16/09/2023.
//

import Foundation

struct Record: Identifiable {
    var id: Int
    var temperature: Double
    var humidity: Double
    var date: Date
    var animate: Bool
}
