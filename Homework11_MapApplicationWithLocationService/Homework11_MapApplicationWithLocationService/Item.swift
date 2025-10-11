//
//  Item.swift
//  Homework11_MapApplicationWithLocationService
//
//  Created by Berkay Emre Aslan on 11.10.2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
