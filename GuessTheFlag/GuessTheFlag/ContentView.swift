//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ahmet Haydar ISIK on 11/11/24.
//

import SwiftUI

struct flagView : View {
    var country: String
    
    var body: some View {
        Image(country)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var selectedFlag = -1
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
   
    @State private var score = 0
    @State private var round = 1
    @State private var isGameOver = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red:0.1, green: 0.2,blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                //.font(.largeTitle.weight(.bold))
                //.foregroundStyle(.white)
                    .titleStyle()
                
                
                VStack (spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                        
                        ForEach(0..<3) { number in
                            Button {
                                flagTapped(number)
                                selectedFlag = number
                            } label: {
                                flagView(country: countries[number])
                                    .rotation3DEffect(
                                        .degrees(number == selectedFlag ? 360:0)
                                        , axis: (x: 0, y: 1, z: 0))
                                    .opacity(number != selectedFlag && selectedFlag != -1 ? 0.25 : 1)
                                    .scaleEffect(number != selectedFlag && selectedFlag != -1 ? 0.5 : 1)
                                   .animation(.easeInOut, value: selectedFlag)
                            }
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Text("Round \(round) of 8")
                    .foregroundStyle(.gray)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
            
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text ("Your score is \(score)")
        }
        .alert("Your final score is \(score)", isPresented: $isGameOver) {
            Button("Restart", action: {
                score = 0
                round = 1
                askQuestion()
            })
        } message: {
            Text("Game Over")
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        selectedFlag = -1
    }
    
    func flagTapped(_ number: Int) {
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        
        if round == 8 {
            isGameOver = true
        }
        else {
            round += 1
            showingScore = true
        }
    }
    
}

#Preview {
    ContentView()
}









extension View {
    func titleStyle() -> some View {
        modifier(LargeBlue())
    }
}

struct LargeBlue : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}
