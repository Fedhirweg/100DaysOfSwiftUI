//
//  AstronautView.swift
//  Moonshot
//
//  Created by Ahmet Haydar ISIK on 6/14/25.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
        
    return AstronautView(astronaut: astronauts["armstrong"]!)
        .preferredColorScheme(.dark)
}
