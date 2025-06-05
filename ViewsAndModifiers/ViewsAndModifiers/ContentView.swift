//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Ahmet Haydar ISIK on 15/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
                .background(.red)
                .padding()
                .background(.blue)
                .padding()
                .background(.green)
                .padding()
                .background(.yellow)
        }
        
      
    }
}

#Preview {
    ContentView()
}
