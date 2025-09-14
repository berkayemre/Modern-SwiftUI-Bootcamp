//
//  DetailView.swift
//  Homework6_UserFlow
//
//  Created by Berkay Emre Aslan on 11.09.2025.
//

import SwiftUI

struct DetailView: View {
    
    let event: Event
    
    @ObservedObject var viewModel: ContentViewModel
    @Environment(\.dismiss) var dismiss
       
       var body: some View {
           VStack(spacing: 20) {
               Text(event.title)
                   .font(.largeTitle)
                   .bold()
               
               Text("Tarih: \(event.date.formatted(date: .long, time: .omitted))")
               Text("Tür: \(event.type.rawValue)")
               Text("Hatırlatıcı: \(event.hasReminder ? "Açık" : "Kapalı")")
               
               Button(role: .destructive) {
                   viewModel.deleteEvent(event)
                   dismiss()
               } label: {
                   Text("Etkinliği Sil")
                       .padding()
                       .frame(height: 50)
               }
               .buttonStyle(.borderedProminent)
           }
           .padding()
           .navigationTitle("Detay")
       }
}

#Preview {
    DetailView(event: Event.init(title: "", date: .now, type: .birthday, hasReminder: false), viewModel: ContentViewModel())
}
