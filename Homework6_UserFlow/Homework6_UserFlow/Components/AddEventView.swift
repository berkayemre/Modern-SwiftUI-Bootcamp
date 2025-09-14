//
//  AddEventView.swift
//  Homework6_UserFlow
//
//  Created by Berkay Emre Aslan on 11.09.2025.
//

import SwiftUI

struct AddEventView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ContentViewModel
       
    @State private var title = ""
    @State private var date = Date()
    @State private var type: EventType = .other
    @State private var hasReminder = false
    @State private var showAlert = false

       
       var body: some View {
           NavigationStack {
               Form {
                   Section(header: Text("Etkinlik Bilgileri")) {
                       TextField("Etkinlik Adı", text: $title)
                       DatePicker("Tarih", selection: $date, displayedComponents: .date)
                       Picker("Tür", selection: $type) {
                           ForEach(EventType.allCases) { type in
                               Text(type.rawValue).tag(type)
                           }
                       }
                       Toggle("Hatırlatıcı", isOn: $hasReminder)
                   }
               }
               .navigationTitle("Yeni Etkinlik")
               .toolbar {
                   ToolbarItem(placement: .confirmationAction) {
                       Button("Kaydet") {
                           if !title.isEmpty {
                               viewModel.addEvent(title: title, date: date, type: type, hasReminder: hasReminder)
                               dismiss()
                           } else {
                               showAlert = true
                           }
                        }
                       .alert("Hata", isPresented: $showAlert) {
                           Button("Tamam", role: .cancel) { }
                       } message: {
                           Text("Etkinlik adı boş geçilemez.")
                       }
                   }
                   ToolbarItem(placement: .cancellationAction) {
                       Button("İptal") { dismiss() }
                   }
               }
           }
       }
}

#Preview {
    AddEventView(viewModel: ContentViewModel())
}
