//
//  ContentView.swift
//  Animations
//
//  Created by Ahmet Haydar ISIK on 29/12/24.
//

import SwiftUI

struct ContentView2: View {
    
    let letters = Array("Hello World!")
    
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        HStack (spacing: 0) {
            ForEach(0..<letters.count, id: \.self) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .red : .blue)
                    .offset(dragAmount)
                    .animation(.linear.delay(Double(num) / 20), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged {dragAmount = $0.translation}
                .onEnded { _ in
                    dragAmount = .zero
                    enabled.toggle()
                    
                }
            
        )
    }
}

#Preview {
    ContentView2()
}
