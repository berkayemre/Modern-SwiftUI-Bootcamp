//
//  MetaRow.swift
//  Homework9_RetrievingDataFromTheAPI
//
//  Created by Berkay Emre Aslan on 23.09.2025.
//

import SwiftUI

func metaRow(year: String?, vote: Double?, runtime: Int?) -> some View {
    
    HStack(spacing: 12) {
        if let year = (year ?? "").split(separator: "-").first {
            InfoChip(title: "Yıl", value: String(year))
        }
        if let vote = vote {
            InfoChip(title: "Puan", value: String(format: "%.1f", vote))
        }
        if let runtime = runtime {
            InfoChip(title: "Süre", value: "\(runtime) dk")
        }
    }
}

