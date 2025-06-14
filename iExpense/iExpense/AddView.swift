//
//  AddView.swift
//  iExpense
//
//  Created by Ahmet Haydar ISIK on 5/1/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var expenses: Expenses
    
    let types = ["Personal", "Business"]
    
    var body: some View {
        
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach (types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add New Expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
