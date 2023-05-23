//
//  UpdateTripView.swift
//  IOS App
//
//  Created by Le Dong on 26/04/2023.
//

import SwiftUI
import Firebase
struct UpdateTripView: View {
    @State private var tripName = ""
    @State private var destination = ""
    @State private var desciption = ""
    @State private var location = ""
    @State private var status = ""
    @State private var date = Date()
    @FocusState private var nameIsFocused: Bool
    @State private var showAlert = false
    var tripPage:[String:String]
    func upload (){
        let db = Firestore.firestore()
        db.collection("TripName").document(self.tripPage["documentId"]!).updateData([
            "tripName": tripName,
            "destination": destination,
            "desciption":desciption,
            "location": location,
            "status": status,
            "pickedDate": pickedDate
        ]){ error in
            if let error = error{
                print(error)
            }else{
            showAlert = true
            }
        }
    }
    
    var pickedDate: String {
        dateToString(date: date, format: "dd/MM/yyyy")
    }
    func dateToString(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Form{
            Section(header: Text("Trip Name")){
                TextField("Enter trip name here...", text:$tripName)
                    .focused($nameIsFocused)
            }
            Section(header: Text("Destination")){
                TextField("Enter destination here..", text: $destination)
                    .focused($nameIsFocused)
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
            Button(action: {
                upload()
            }, label: {
                Text("Update")
                .frame(maxWidth: .infinity, alignment: .center)
            }).alert("UPDATE SUSSCES", isPresented: $showAlert) {
                Button("OK", role: .cancel){
                    presentationMode.wrappedValue.dismiss()
                }.onDisappear {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle("Update Trip \(tripPage["tripName"] ?? "")")
        }
    }
 
}

//struct UpdateTripView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateTripView()
//    }
//}
