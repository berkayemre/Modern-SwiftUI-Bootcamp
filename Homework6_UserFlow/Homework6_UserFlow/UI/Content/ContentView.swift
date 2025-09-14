//
//  ContentView.swift
//  Homework6_UserFlow
//
//  Created by Berkay Emre Aslan on 11.09.2025.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    @State private var showAddEvent = false
        
        var body: some View {
            NavigationStack {
                List {
                    ForEach(viewModel.events, id: \.id) { event in
                        NavigationLink(value: event) {
                            VStack(alignment: .leading) {
                                Text(event.title)
                                    .font(.headline)
                                Text(event.date, style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text(event.type.rawValue)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.map { viewModel.events[$0] }.forEach(viewModel.deleteEvent)
                    }
                }
                .navigationTitle("Etkinlikler")
                .toolbar {
                    Button {
                        showAddEvent = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $showAddEvent) {
                    AddEventView(viewModel: viewModel)
                }
                .navigationDestination(for: Event.self) { event in
                    DetailView(event: event, viewModel: viewModel)
                }
            }
        }
}

#Preview {
    ContentView()
}
