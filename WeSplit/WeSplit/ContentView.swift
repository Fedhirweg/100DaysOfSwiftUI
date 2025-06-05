//
//  ContentView.swift
//  WeSplit
//
//  Created by Ahmet Haydar ISIK on 4/11/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var checkAmount : Double = 0
    @State var numberOfPeople : Int = 2
    @State var tipPercantage : Int = 0
    
    //let tipPercantages = [10, 15, 20, 25, 0]
    
    var grandTotal : Double {
        if (checkAmount == 0) {return 0}
        let tipValue = checkAmount * Double(tipPercantage) / 100
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var amountPerPerson : Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercantage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
    
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    @FocusState var amountIsFocused : Bool
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    
                    TextField("Enter the check amount", value: $checkAmount ,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }//.pickerStyle(.navigationLink)
                    
                }
                
//                Section("How much do you want to tip?"){
//                    Picker("Tip percantage", selection: $tipPercantage) {
//                        ForEach(tipPercantages, id : \.self) {
//                            Text($0, format: .percent)
//                        }
//                    }.pickerStyle(.segmented)
//                    
//                }
                
                Section("How much do you want to tip?"){
                    Picker("Tip percantage", selection: $tipPercantage) {
                        ForEach(0..<101) { value in
                            Text(value , format: .percent)
                        }
                    }
                    
                }
                
                Section("Total Amount") {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercantage == 0 ? .red : .primary)
                }
                
                
                Section("Amount per person"){
                    Text(amountPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
        
    }
    
}

#Preview {
    ContentView()
}
