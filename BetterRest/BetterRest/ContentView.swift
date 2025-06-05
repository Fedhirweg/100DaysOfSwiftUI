//
//  ContentView.swift
//  BetterRest
//
//  Created by Ahmet Haydar ISIK on 22/12/24.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var idealBedTime : String {
        var bedTime = ""
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            bedTime = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch{
            bedTime = "We couln't calculate your bedtime"
        }
        return bedTime
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section("When do you want to wake up?") {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }.font(.headline)
                
                Section("Desired amount of sleep"){
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }.font(.headline)
                
                Section("Daily coffee intake"){
                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                    
                    Picker("^[\(coffeeAmount) cup](inflect: true)", selection: $coffeeAmount) {
                        ForEach (1...20, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                }
                .font(.headline)
                
                Section("Recommended bed time") {
                    Text(idealBedTime)
                }
                .font(.headline)
            }
            .navigationTitle("BetterRest")
            
        }
    }
}
//    func calculateBedTime () {
//        do {
//            let config = MLModelConfiguration()
//            let model = try SleepCalculator(configuration: config)
//            
//            let companents = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
//            
//            let hour = (companents.hour ?? 0) * 60 * 60
//            let minute = (companents.minute ?? 0) * 60
//            
//            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
//            
//            let sleepTime = wakeUp - prediction.actualSleep
//            
//            alertTitle = "Your ideal bedtime is..."
//            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
//            
//        } catch {
//            alertTitle = "Error"
//            alertMessage = "We couldn't calculate"
//          
//        }
//        showingAlert = true
//    }
//    
//}


#Preview {
    ContentView()
}
