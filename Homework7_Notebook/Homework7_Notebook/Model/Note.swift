//
//  Note.swift
//  Homework7_Notebook
//
//  Created by Berkay Emre Aslan on 15.09.2025.
//

import Foundation

struct Note: Codable, Identifiable {
    let id: UUID
    var title: String
    var content: String
    let date: Date
    
    init(title: String, content: String) {
        self.id = UUID()
        self.title = title
        self.content = content
        self.date = Date()
    }
}
