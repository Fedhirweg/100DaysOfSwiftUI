//
//  ContentView.swift
//  Animations
//
//  Created by Ahmet Haydar ISIK on 29/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button ("Tap Me") {
          //  animationAmount += 1
            withAnimation(.spring(duration: 1, bounce: 0.5)){
                animationAmount += 360
            }
        }.padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
        
        
        /*/.overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2-animationAmount)
                .animation(.easeInOut(duration: 1)
                    .repeatForever(autoreverses: false),
                           value: animationAmount)
        )*/
    }
}

#Preview {
    ContentView()
}
