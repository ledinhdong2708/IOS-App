//
//  ContentView.swift
//  IOS App
//
//  Created by Le Dong on 12/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 0
    var body: some View {
        ZStack{
            TabView(selection: $tabSelection){
                HomeView(changePage: $tabSelection)
                    .tabItem{
                        VStack{
                            Image(systemName:"house.circle.fill")
                            Text("Home")
                        }
                    }.tag(0)
                    NewTripView(changePage: $tabSelection)
                    .tabItem{
                        VStack{
                            Image(systemName:"plus.circle.fill")
                            Text("New Trip")
                        }
                    }.tag(1)
                ListTripView()
                    .tabItem{
                        VStack{
                            Image(systemName: "list.bullet.circle.fill")
                            Text("Trip List")
                        }
                    }.tag(2)
                    AboutView()
                    .tabItem{
                        VStack{
                            Image(systemName:"square.and.pencil.circle.fill")
                            Text("About")
                        }
                    }.tag(3)
                
            }
        }
        .background(.white)
        }
        
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}









