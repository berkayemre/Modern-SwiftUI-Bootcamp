//
//  ContentView.swift
//  Homework5_MasterList
//
//  Created by Berkay Emre Aslan on 4.09.2025.
//

import SwiftUI

enum ListMode: String, CaseIterable, Identifiable {
    case list = "Liste"
    case alternative  = "Alternatif"
    var id: String { rawValue }
}

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()

    @State private var themeColor: Color = .blue
    @State private var mode: ListMode = .list

    var body: some View {
        NavigationStack {
            Group {
                if mode == .list {
                    listView
                } else {
                    alternativeView
                }
            }
            .navigationTitle("Master List App")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Picker("Görünüm", selection: $mode) {
                        ForEach(ListMode.allCases) { m in
                            Text(m.rawValue).tag(m)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 220)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button { viewModel.isAlertShowing.toggle() } label: {
                        Image(systemName: "plus")
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        randomizeTheme()
                    } label: {
                        Image(systemName: "paintbrush.fill")
                    }
                    .help("Temayı rastgele değiştir")
                }
            }
            .navigationDestination(for: Item.self) { item in
                DetailView(item: item)
            }
        }
        .tint(themeColor)
        .onAppear { randomizeTheme() }
        .alert("Create a new item", isPresented: $viewModel.isAlertShowing) {
            TextField("New Item Title", text: $viewModel.newItemTitle)
            TextField("New Item Description", text: $viewModel.newItemDescription)
            Button("Add") {
                viewModel.addItem(viewModel.newItemTitle, viewModel.newItemDescription)
            }
        }
    }

    // MARK: - Liste Görünümü
    private var listView: some View {
        List {
            Section(header: Text("TAMAMLANACAKLAR")
                .font(.headline)
                .bold()
                .foregroundStyle(themeColor)
            ) {
                ForEach(viewModel.items.filter { !$0.isDone }) { item in
                    HStack {
                        NavigationLink(value: item) {
                            RowView(title: item.title, description: item.description)
                        }
                        Spacer()
                        Button {
                            viewModel.markAsDone(item)
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .imageScale(.large)
                        }
                        .buttonStyle(.borderless)
                        .accessibilityLabel("Tamamla")
                    }
                    .swipeActions {
                        Button(role: .destructive) { viewModel.deleteItem(with: item) } label: {
                            Text("Delete")
                        }
                    }
                }
            }

            Section(header: Text("TAMAMLANANLAR")
                .font(.headline)
                .bold()
                .foregroundStyle(themeColor)) {
                ForEach(viewModel.items.filter { $0.isDone }) { item in
                    NavigationLink(value: item) {
                        RowView(title: item.title, description: item.description)
                    }
                    .swipeActions {
                        Button(role: .destructive) { viewModel.deleteItem(with: item) } label: {
                            Text("Delete")
                        }
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
    }

    // MARK: - Alternatif Görünüm (ScrollView + LazyVStack)
    private var alternativeView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                Text("TAMAMLANACAKLAR")
                    .font(.headline)
                    .bold()
                    .foregroundStyle(themeColor)
                    .padding(.horizontal, 40)

                LazyVStack(spacing: 12) {
                    ForEach(viewModel.items.filter { !$0.isDone }) { item in
                        HStack(spacing: 12) {
                            NavigationLink(value: item) {
                                RowView(title: item.title, description: item.description)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(.background, in: RoundedRectangle(cornerRadius: 12))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(themeColor.opacity(0.2), lineWidth: 1)
                                    )
                            }

                           
                            Button {
                                viewModel.markAsDone(item)
                            } label: {
                                Image(systemName: "checkmark.circle")
                                    .imageScale(.large)
                                    .foregroundColor(themeColor)

                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Tamamla")

                            
                            Button(role: .destructive) {
                                viewModel.deleteItem(with: item)
                            } label: {
                                Image(systemName: "trash")
                                    .imageScale(.large)
                                    .foregroundColor(themeColor)

                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Sil")
                        }
                        .padding(.horizontal)
                    }
                }

                Text("TAMAMLANANLAR")
                    .font(.headline)
                    .bold()
                    .foregroundStyle(themeColor)
                    .padding(.horizontal, 40)


                LazyVStack(spacing: 12) {
                    ForEach(viewModel.items.filter { $0.isDone }) { item in
                        HStack(spacing: 12) {
                            NavigationLink(value: item) {
                                RowView(title: item.title, description: item.description)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(.background, in: RoundedRectangle(cornerRadius: 12))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(themeColor.opacity(0.2), lineWidth: 1)
                                    )
                            }

                            
                            Button {
                                viewModel.markAsUndone(item)
                            } label: {
                                Image(systemName: "arrow.uturn.left.circle")
                                    .imageScale(.large)
                                    .foregroundColor(themeColor)

                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Geri Al")

                            Button(role: .destructive) {
                                viewModel.deleteItem(with: item)
                            } label: {
                                Image(systemName: "trash")
                                    .imageScale(.large)
                                    .foregroundColor(themeColor)

                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Sil")
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical, 16)
        }
    }

    private func randomizeTheme() {
        let palette: [Color] = [.blue, .green, .teal, .indigo, .purple, .orange, .pink, .cyan, .mint]
        themeColor = palette.randomElement() ?? .blue
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel())
}
