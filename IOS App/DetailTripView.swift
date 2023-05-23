//
//  DetailTripView.swift
//  IOS App
//
//  Created by Le Dong on 19/04/2023.
//

import SwiftUI
import Firebase
struct DetailTripView : View {
    
    @State var showAlert = false
    let tripPage: [String:String]
    @State private var tabSelection = 0
    var body : some View{
        List{
            
            HStack{
                Image(systemName: "location.circle.fill")
                Text(tripPage["destination"] ?? "")
            }
            HStack{
                Image(systemName: "calendar")
                Text(tripPage["pickedDate"] ?? "")
            }
            HStack{
                Image(systemName: "info.bubble")
                Text(tripPage["desciption"] ?? "")
            }
            HStack{
                Image(systemName: "location.magnifyingglass")
                Text(tripPage["location"] ?? "")
            }
            HStack{
                Image(systemName: "person.fill.checkmark")
                Text(tripPage["status"] ?? "")
            }
            Section(header:Text("Expense in a trip")){
                NavigationLink(destination: AddExpend(tripPage: tripPage)){
                    HStack{
                        Text("Add Expenses")
                    }
                }
                
                HStack{
                    Text("Date and time:")
                    Text(tripPage["pickedDateExpense"] ?? "")
                }
                HStack{
                    Text("Transportation:")
                    Text("\(tripPage["transportation"] ?? "") VND")
                }
                HStack{
                    Text("Hotel:")
                    Text("\(tripPage["hotel"] ?? "") VND")
                }
                HStack{
                    Text("Food:")
                    Text("\(tripPage["food"] ?? "") VND")
                }
                HStack{
                    Text("\(tripPage["nameExpense"] ?? ""):")
                    Text("\(tripPage["otherPrice"] ?? "") VND")
                }.navigationTitle(tripPage["tripName"] ?? "")
             
            }
        }

        .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: UpdateTripView(tripPage: tripPage)){
                            Text("Update")
                        }
                    }
                }
        
        
    }
}
