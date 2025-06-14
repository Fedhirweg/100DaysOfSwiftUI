//
//  ContentView.swift
//  Moonshot
//
//  Created by Ahmet Haydar ISIK on 5/2/25.
//

import SwiftUI

struct ContentView: View {
    
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingGrid = true
    
    var body: some View {
        NavigationStack {
            Group {
                if showingGrid {
                    GridView(astronauts: astronauts, missions: missions)
                } else {
                    ListView(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingGrid.toggle()
                    }) {
                        Image(systemName: showingGrid ? "list.dash" : "square.grid.2x2")
                            .imageScale(.large)
                            .foregroundStyle(.white)
                    }
                }
                
                
            }
        }.navigationViewStyle(StackNavigationViewStyle())
            .preferredColorScheme(.dark)
    }
}
#Preview {
    ContentView()
}
