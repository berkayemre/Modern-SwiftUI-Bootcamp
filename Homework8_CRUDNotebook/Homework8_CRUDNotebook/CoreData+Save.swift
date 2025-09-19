//
//  CoreData+Save.swift
//  Homework8_CRUDNotebook
//
//  Created by Berkay Emre Aslan on 19.09.2025.
//

import CoreData

extension NSManagedObjectContext {
    func saveIfNeeded() {
        if hasChanges {
            do {
                try save()
            } catch {
                print("CoreData save error:", error)
            }
        }
    }
}
