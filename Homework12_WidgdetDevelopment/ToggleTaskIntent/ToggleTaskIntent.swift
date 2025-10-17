//
//  ToggleTaskIntent.swift
//  ToggleTaskIntent
//
//  Created by Berkay Emre Aslan on 15.10.2025.
//

import AppIntents

struct ToggleTaskIntent: AppIntent {
    static var title: LocalizedStringResource { "ToggleTaskIntent" }
    
    func perform() async throws -> some IntentResult {
        return .result()
    }
}
