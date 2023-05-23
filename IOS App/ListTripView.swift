//
//  ListTripView.swift
//  IOS App
//
//  Created by Le Dong on 13/04/2023.
//

import SwiftUI
import Firebase
import Foundation
import FirebaseFirestore

struct ListTripView: View {
    @State private var title: String = ""
    @State private var trip: [[String: String]] = []
    @State var showAlert = false
    //Search value
    @State private var searchText = ""
    
    var db = Firestore.firestore()
    private func download() {
          db.collection("TripName").getDocuments { (snapshot, error) in
              if let snapshot = snapshot {
                  self.trip = snapshot.documents.map { i in
                      return [
                        "tripName": i.data()["tripName"] as! String,
                        "destination": i.data()["destination"] as! String,
                        "pickedDate": i.data()["pickedDate"] as! String,
                        "location": i.data()["location"] as! String,
                        "desciption": i.data()["desciption"] as! String,
                        "status": i.data()["status"] as! String,
                        "transportation": i.data()["transportation"] as! String,
                        "food": i.data()["food"] as! String,
                        "hotel": i.data()["hotel"] as! String,
                        "nameExpense": i.data()["nameExpense"] as! String,
                        "otherPrice": i.data()["otherPrice"] as! String,
                        "pickedDateExpense": i.data()["pickedDateExpense"] as! String,
                        "documentId": i.documentID
                      ]
                  }
                  
              }
              
          }
          
      }
    
    private func deleteTrip(at indexSet: IndexSet) {
           
           indexSet.forEach { index in
               
               let trip = self.trip[index]
               
               db.collection("TripName").document(trip["documentId"]!).delete() { error in
                   
                   if let error = error {
                       print(error.localizedDescription)
                   } else {
                       self.download()
                   }
               }
               
           }
           
       }
    
    var filteredTrip: [[String: String]] {
        if searchText.isEmpty {
            return trip
        } else {
            return trip.filter { $0["tripName"]?.localizedCaseInsensitiveContains(searchText) == true }
        }
    }
    
    var body: some View {
        VStack{
                List{
                    ForEach(filteredTrip, id: \.self){ trip in
                        NavigationLink(destination: DetailTripView(tripPage: trip)){
                            VStack(alignment: .leading){
                                Text(trip["tripName"] ?? "")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                HStack{
                                    Text(trip["pickedDate"] ?? "")
                                    Text("-")
                                    Text(trip["destination"] ?? "")
                                }
                            }
                        }
                    }.onDelete(perform: self.deleteTrip)
                }
            }
            .searchable(text: $searchText)
            .onAppear {self.download()}
            .navigationBarTitle("Trip List")
            .embedInNavigationView()
    }
 
}

struct ListTripView_Previews: PreviewProvider {
    static var previews: some View {
         ListTripView()
    }
}


