//
//  ContentViewModel.swift
//  Homework6_UserFlow
//
//  Created by Berkay Emre Aslan on 11.09.2025.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    @Published var events: [Event] = []
        
    func addEvent(title: String, date: Date, type: EventType, hasReminder: Bool) {
           let newEvent = Event(title: title, date: date, type: type, hasReminder: hasReminder)
           events.append(newEvent)
       }
       
       func deleteEvent(_ event: Event) {
           events.removeAll { $0.id == event.id }
       }
       
       func toggleReminder(for event: Event) {
           if let index = events.firstIndex(where: { $0.id == event.id }) {
               events[index].hasReminder.toggle()
           }
       }
}
