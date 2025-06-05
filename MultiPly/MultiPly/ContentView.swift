//
//  ContentView.swift
//  MultiPly
//
//  Created by Ahmet Haydar ISIK on 31/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isGameActive = false
    @State private var questions : [Question] = []
    
    var body: some View {
        if isGameActive {
            GameView(questions: questions) {
                isGameActive = false
            }
        } else {
            Text("MultiPly")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                
            
            GameSettings { number, count in
                generateQuestions(upTo: number, count: count)
                isGameActive = true
            }
        }
    }
    
    func generateQuestions(upTo number: Int, count: Int) {
        questions.removeAll()
        
        for _ in 1...count {
            let first = Int.random(in: 2...number)
            let second = Int.random(in: 2...12)
            let question = "\(first) x \(second)"
            let answer = first * second
            questions.append(Question(question: question, answer: answer))
        }
    }
}




struct Question: Identifiable {
    var id = UUID()
    var question: String
    var answer: Int
}

#Preview {
    ContentView()
}
