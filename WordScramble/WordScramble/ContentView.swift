//
//  ContentView.swift
//  WordScramble
//
//  Created by Ahmet Haydar ISIK on 24/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    var score: Int {
        usedWords.reduce(0) { total, word in
            total + word.count
        }
    }
    
    @State private var newWord = ""
    @State private var rootWord = ""
    @State private var usedWords = [String]()
    
    var body: some View {
        NavigationStack {
            
            VStack (alignment: .trailing){
                Text("Score: \(score)")
                    .foregroundStyle(.green)
            }
            List {
                Section {
                    TextField("Enter your word", text:$newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit {
                addNewWord()
            }
            .onAppear(perform: gameStart)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK") { }
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                Button("Restart") {
                    withAnimation{
                        gameStart()
                        usedWords.removeAll()}
                    }
        }
        
        }

    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        //exit if remeanin string is empty
        guard answer.count > 0 else {return}
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word already used", message: "Be more original")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word is not real", message: "Don't make up new words")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word is not possible", message: "You can't spell that")
            return
        }
        
        guard isLong(word: answer) else {
            wordError(title: "Word is too short", message: "You can't use words shorter than 3 letters")
            return
        }
        
        guard isDifferent(word: answer) else {
            wordError(title: "Can't use the given word", message: "Be creative and use something else")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }

        newWord = ""
        
    }
    
    func gameStart() {
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsUrl, encoding: .utf8) {
               let allWords = startWords.components(separatedBy: "\n")
               
               rootWord = allWords.randomElement() ?? "silkworm"
               
               return
            }
        }
        
        fatalError("Couldn't load start.txt file")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isLong(word: String) -> Bool {
        word.count > 2
    }
    
    func isDifferent(word: String) -> Bool {
        !(word == rootWord)
    }
    
    
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
   
}

#Preview {
    ContentView()
}
