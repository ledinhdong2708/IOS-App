//
//  NewTripView.swift
//  IOS App
//
//  Created by Le Dong on 13/04/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import Foundation
struct NewTripView: View {
    @State private var tripName = ""
    @State private var destination = ""
    @State private var desciption = ""
    @State private var location = ""
    @State private var status = ""
    @State private var isOn = false
    @State private var date = Date()
    @State private var showAlert = false
    @State private var showAlertTripName = false
    @State private var showAlertDestination = false
    @State private var showAlertRisk = false

    @State var transportation = ""
    @State var food = ""
    @State var hotel = ""
    @State var otherPrice = ""
    @State var nameExpense = ""
    @State private var pickedDateExpense = ""
    @Binding var changePage: Int
    
    
    
    @FocusState private var nameIsFocused: Bool
    
    
    var pickedDate: String {
        dateToString(date: date, format: "dd/MM/yyyy")
    }
  
    func dateToString(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
    func upload (){
        let db = Firestore.firestore()
        db.collection("TripName").addDocument(data:[
            "tripName": tripName,
            "destination": destination,
            "desciption":desciption,
            "location": location,
            "status": status,
            "pickedDate": pickedDate,
            "transportation": transportation,
            "food": food,
            "hotel": hotel,
            "nameExpense": nameExpense,
            "otherPrice": otherPrice,
            "pickedDateExpense": pickedDateExpense
        ]){ error in
            if let error = error{
                print(error)
            }else{
            showAlert = true
            }
        }
    }
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Trip Name")){
                    TextField("Enter trip name here...", text:$tripName)
                        .focused($nameIsFocused)
                }.alert(isPresented: $showAlertTripName) {
                    Alert(
                        title: Text("Required"),
                        message: Text("Trip Name is empty")
                    )
                }
                Section(header: Text("Destination")){
                    TextField("Enter destination here..", text: $destination)
                        .focused($nameIsFocused)
                }.alert(isPresented: $showAlertDestination) {
                    Alert(
                        title: Text("Required"),
                        message: Text("Destination is empty")
                    )
                }

                Section(header:Text("Date")){
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
                Section(header: Text("Desciption(Optional)")){
                    TextField("Enter desciption here..", text: $desciption)
                        .focused($nameIsFocused)
                }
                Section(header: Text("Location(Optional)")){
                    TextField("Enter location here..", text: $location)
                        .focused($nameIsFocused)
                }
                Section(header: Text("Status(Optional)")){
                    TextField("Enter status here..", text: $status)
                        .focused($nameIsFocused)
                }
                Section(header: Text("Required Risk Assessment")){
                    Toggle("Required",isOn:$isOn)
                }.alert(isPresented: $showAlertRisk) {
                    Alert(
                        title: Text("Required"),
                        message: Text("Plese check risk assessment")
                    )
                }
                Button(action: {
                    if tripName.isEmpty {
                    showAlertTripName = true
                    }
                    else if destination.isEmpty{
                        showAlertDestination = true
                    }
                    else if isOn == false {
                        showAlertRisk = true
                    }
                    else{
                        upload()
                    }
                }, label: {
                    Text("Create Trip")
                        .frame(maxWidth: .infinity, alignment: .center)
                })
                
            }
            .alert("Create trip success", isPresented: $showAlert) {
                Button(action: {
                    changePage = 2
                }, label: {
                    Text("OK")
                })
            }
            .navigationTitle("Create New Trip")
        }
        
        
    }

 
}




