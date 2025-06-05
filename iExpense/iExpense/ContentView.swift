//
//  ContentView.swift
//  iExpense
//
//  Created by Ahmet Haydar ISIK on 1/1/25.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
    
struct ContentView: View {
    
    @State private var expenses = Expenses()
    @State private var showingAddExpenseView = false
    
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(expenses.items, id: \.id) { item in
                    HStack{
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                            .foregroundColor(item.amount < 10 ? .green : item.amount < 100 ? .yellow : .red)
                            .font(.headline)
                        }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle(Text("Expenses"))
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpenseView = true
                    
                }
            }
            .sheet(isPresented: $showingAddExpenseView){
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
}



#Preview {
    ContentView()
}
