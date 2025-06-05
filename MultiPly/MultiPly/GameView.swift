//
//  GameView.swift
//  MultiPly
//
//  Created by Ahmet Haydar ISIK on 1/1/25.
//

import SwiftUI

struct GameView: View {
    let questions: [Question]
    @State private var currentQuestionIndex = 0
    @State private var userAnswer = ""
    @State private var score = 0
    
    var endGame: () -> Void
    
    var body: some View {
        VStack {
            
            if (currentQuestionIndex < questions.count) {
                Text ("What is \(questions[currentQuestionIndex].question)?")
                
                TextField("Enter your answer", text: $userAnswer)
                    .keyboardType(.numberPad)
                    .padding()
                
                Button("Submit") {
                    checkAnswer()
                }
            }
            else {
                Text("Game Over")
                Text("Your score is \(score) / \(questions.count)")
                
                
                Button ("Play Again") {
                    endGame()
                }
            }
        }
    }
    
    func checkAnswer () {
        let correctAnswer = questions[currentQuestionIndex].answer
        if (Int(userAnswer) == correctAnswer) {
            score += 1
        }
        userAnswer = ""
        currentQuestionIndex += 1
    }
}
#Preview {
    var questions = [Question(question: "2 x 2", answer: 4), Question(question: "2 x 3", answer: 6), Question(question: "2 x 4", answer: 8)]
    GameView(questions: questions){
        print("Game over")
    }
}
