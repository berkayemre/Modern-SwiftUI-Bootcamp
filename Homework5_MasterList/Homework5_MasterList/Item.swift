//
//  Model.swift
//  Homework5_MasterList
//
//  Created by Berkay Emre Aslan on 5.09.2025.
//

import Foundation

struct Item: Identifiable, Hashable {
    var id: UUID = UUID()
    var title: String
    var description: String
    var isDone: Bool = false
}
