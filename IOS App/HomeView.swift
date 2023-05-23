//
//  HomeView.swift
//  IOS App
//
//  Created by Le Dong on 13/04/2023.
//

import SwiftUI
import Firebase
struct HomeView: View {
    @Binding var changePage: Int
    @State var showAlert = false
    var db = Firestore.firestore()
    private func deleteAllData() {
           db.collection("TripName").getDocuments() { snapshot, error in
               if let error = error {
                   print("Error getting documents: \(error)")
               } else {
                   for document in snapshot!.documents {
                       document.reference.delete()
                   }
               }
           }
       }
    var body: some View {
        VStack {
            navBarView(textNavBar: "Home")
            Text("Select Activity")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(hue: 0.825, saturation: 0.584, brightness: 0.887))
            HStack(alignment: .center, spacing: 30){
                Button(action: {
                    self.changePage = 1
                }, label: {
                    ActivityIcon(imgIcon: "plus.circle.fill", textContent: "New Trip", colorIcon: .green)
                })
                Button(action: {
                    self.changePage = 2
                }, label: {
                    ActivityIcon(imgIcon: "list.bullet.circle.fill", textContent: "Trip List", colorIcon: .orange)
                })
            }.padding()
            HStack(alignment: .center, spacing: 30){
                Button(action: {
                    self.changePage = 3
                }, label: {
                    ActivityIcon(imgIcon: "square.and.pencil.circle.fill", textContent: "About", colorIcon: .red)
                })
                    Button(action: {
                        deleteAllData()
                    }, label: {
                        ActivityIcon(imgIcon: "arrowshape.turn.up.left.circle.fill", textContent: "Reset", colorIcon: .orange)
                    }).alert("Delete Success", isPresented: $showAlert) {
                        Button("OK", role: .cancel) {}
                    }
            }.padding()
            Button(action: {
                self.changePage = 5
            }, label: {
                ActivityIcon(imgIcon: "square.and.arrow.up.circle.fill", textContent: "Backup", colorIcon: .orange)
            })
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


struct ActivityIcon: View {
    var imgIcon: String
    var textContent: String
    var colorIcon:Color
    var body: some View {
        VStack{
            Image(systemName: imgIcon)
                .foregroundColor(colorIcon)
                .font(.system(size:40))
            Text(textContent)
        }
        .frame(width:150, height: 150)
        .background(.white)
        .cornerRadius(10)
        .background(
            Rectangle()
                .cornerRadius(10)
                .shadow(radius: 5)
        )
    }
}

struct navBarView: View {
    var textNavBar: String
    var body: some View {
        HStack{
            Text(textNavBar)
                .font(.title)
            Spacer()
        }
        .padding()
        .background(Color.yellow)
    }
}

