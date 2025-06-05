//
//  ContentView.swift
//  UnitConverter
//
//  Created by Ahmet Haydar ISIK on 7/11/24.
//

import SwiftUI

struct ContentView: View {
    
    let lenghtUnits = ["meters","kilometers", "feet", "yard", "miles" ]
    
    @State var inputUnit = "meters"
    @State var outputUnit = "kilometers"
    
    @State var inputValue : Double = 0
    
    var result : Double {
        switch (inputUnit, outputUnit) {
        case ("meters", "kilometers"): return inputValue / 1000
        case ("kilometers", "meters"): return inputValue * 1000
        case ("feet", "yard"): return inputValue / 3.28084
        case ("yard", "feet"): return inputValue * 3.28084
        default : return 0
        }
    }
    
    
    var body: some View {
        Form {
            Section ("Units") {
                Picker("Input Unit", selection: $inputUnit) {
                    ForEach(lenghtUnits, id: \.self) { unit in
                        Text(unit)
                    }
                }
                
                Picker("Output Unit", selection: $outputUnit) {
                    ForEach(lenghtUnits, id: \.self) { unit in
                        if unit != inputUnit {
                            Text(unit)
                        }
                    }
                }
            }
            
            Section ("Input") {
                
                TextField("Enter a value", value: $inputValue, format: .number)
            }
            
            Section ("Result") {
                Text(result, format:.number)
                
            }
            
        }
    }
}

#Preview {
    ContentView()
}
