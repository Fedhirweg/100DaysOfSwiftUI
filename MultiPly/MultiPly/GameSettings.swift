//
//  GameSettings.swift
//  MultiPly
//
//  Created by Ahmet Haydar ISIK on 31/12/24.
//

import SwiftUI

struct GameSettings: View {
    @State private var selectedNumber = 2
    @State private var selectedQuestion = 5
    
    let startGame: (Int, Int) -> Void
    
 
    
    var body: some View {
        VStack {
            Section {
                
                Text("Select multiplication tables")
                Stepper("Up to \(selectedNumber)", value: $selectedNumber, in: 2...12)
                    .padding()
            }
            
            Section ("How many questions do you want to answer?") {
                Picker("Questions", selection: $selectedQuestion) {
                    ForEach([5, 10, 20], id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
    
            
            
            Button("Start Game") {
               startGame(selectedNumber, selectedQuestion)
            }
            
        }
    }
}





#Preview {
    GameSettings { number, count in
        print("Starting game with \(number) up to \(count)")
    }
}
