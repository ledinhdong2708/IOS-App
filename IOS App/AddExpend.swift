//
//  AddExpend.swift
//  IOS App
//
//  Created by Le Dong on 21/04/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import Foundation

struct AddExpend: View {
    class NumbersOnly: ObservableObject {
        @Published var value = "" {
            didSet {
                let filtered = value.filter { $0.isNumber }
                
                if value != filtered {
                    value = filtered
                }
            }
        }
    }
    @ObservedObject var transportation = NumbersOnly()
    @ObservedObject var food = NumbersOnly()
    @ObservedObject var hotel = NumbersOnly()
    @ObservedObject var otherPrice = NumbersOnly()
    @State var nameExpense = ""
    @State private var dateExpense = Date()
    @FocusState private var nameIsFocused: Bool
    var tripPage:[String:String]
    var pickedDateExpense: String {
        dateToString(dateExpense: dateExpense, format: "dd/MM/yyyy HH:mm")
    }
    func dateToString(dateExpense: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: dateExpense)
    }
    @State var showAlert = false
    @State var showAlertTransportation = false
    @State var showAlertFood = false
    @State var showAlertHotel = false
    func uploadExpense (){
        let db = Firestore.firestore()
        db.collection("TripName").document(self.tripPage["documentId"]!).updateData([
            "transportation":self.transportation.value,
            "food":self.food.value,
            "hotel":self.hotel.value,
            "nameExpense":self.nameExpense,
            "otherPrice":self.otherPrice.value,
            "pickedDateExpense":self.pickedDateExpense
        ]){ error in
            if let error = error{
                print(error)
            }else{
            showAlert = true
            }
        }
    }
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Form{
            Section(header: Text("Main expenses")
                .multilineTextAlignment(.leading)
                    ){
                TextField("Transportation price..", text:$transportation.value)
                    .keyboardType(.decimalPad)
                    .focused($nameIsFocused)
                    .alert(isPresented: $showAlertTransportation) {
                        Alert(
                            title: Text("Required"),
                            message: Text("Transportation is empty")
                        )
                    }
                TextField("Food price..", text:$food.value)
                    .keyboardType(.decimalPad)
                    .focused($nameIsFocused)
                    .alert(isPresented: $showAlertFood) {
                        Alert(
                            title: Text("Required"),
                            message: Text("Food is empty")
                        )
                    }

                TextField("Hotel price..", text:$hotel.value)
                    .keyboardType(.decimalPad)
                    .focused($nameIsFocused)
                    .alert(isPresented: $showAlertHotel) {
                        Alert(
                            title: Text("Required"),
                            message: Text("Hotel is empty")
                        )
                    }

                DatePicker("Date", selection: $dateExpense, displayedComponents: [.date, .hourAndMinute])
                }
            
            
                Section(header: Text("Other expenses (Optional)")
                    .multilineTextAlignment(.leading)
                        ){
                    TextField("Names of expenses", text:$nameExpense)
                    TextField("Price..", text:$otherPrice.value)
                        .keyboardType(.decimalPad)
                    }
            Section{
                Button(action: {
                    if transportation.value.isEmpty{
                        showAlertTransportation = true
                    }
                    else if food.value.isEmpty{
                        showAlertFood = true
                    }
                    else if hotel.value.isEmpty{
                        showAlertHotel = true
                    }
                    else{
                        uploadExpense()
                    }
                
                }, label: {
                    Text("Create Expense")
                        .frame(maxWidth: .infinity, alignment: .center)
                })
                .alert("Add expense success", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .onDisappear {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
            }
        }
        .navigationTitle("Add Expense \(tripPage["tripName"] ?? "")")
        
    }
}

//struct AddExpend_Previews: PreviewProvider {
//    static var previews: some View {
//        AddExpend().embedInNavigationView()
//    }
//}
