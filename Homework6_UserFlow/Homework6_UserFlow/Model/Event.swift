//
//  Event.swift
//  Homework6_UserFlow
//
//  Created by Berkay Emre Aslan on 11.09.2025.
//

import Foundation

struct Event: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var date: Date
    var type: EventType
    var hasReminder: Bool
}

enum EventType: String, CaseIterable, Identifiable {
    case birthday = "Doğum Günü"
    case meeting = "Toplantı"
    case holiday = "Tatil"
    case sport = "Spor"
    case other = "Diğer"
    
    var id: String { self.rawValue }
}


