//
//  ContentView.swift
//  Homework4_SimpleCounterImplementationWith@State
//
//  Created by Berkay Emre Aslan on 31.08.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var count = 0
    
    var body: some View {
        VStack{
            Text("\(count)")
            Stepper("Count", value: $count)
            Button("Reset") {
                count = 0
            }
            .frame(width: 150, height: 50)
            .foregroundStyle(.red)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
