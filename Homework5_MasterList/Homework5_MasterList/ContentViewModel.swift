//
//  ContentViewModel.swift
//  Homework5_MasterList
//
//  Created by Berkay Emre Aslan on 4.09.2025.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    @Published var items: [Item] = []
    @Published var isAlertShowing: Bool = false
    @Published var newItemTitle: String = ""
    @Published var newItemDescription: String = ""
    
    init() {
           items = (1...10).map { i in
               Item(title: "Başlık \(i)", description: "Açıklama \(i)")
           }
       }
    
    func addItem(_ title: String, _ description: String) {
        guard !title.isEmpty else { return }
        let item = Item(title: title, description: description)
        items.append(item)
        newItemTitle = ""
        newItemDescription = ""
    }
    
    func deleteItem(with item: Item) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
    
    func markAsDone(_ item: Item) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isDone = true
        }
    }
    
    func markAsUndone(_ item: Item) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isDone = false
        }
    }
}
