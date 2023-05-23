//
//  AboutView.swift
//  IOS App
//
//  Created by Le Dong on 12/04/2023.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 50){
            Text("Travel App")
                .font(.system(size: 30, weight: .bold))
            Image("logoGreenwich")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 100)
            Text("Contact")
                .font(.system(size: 20, weight: .bold))
            VStack{
                Text("Author")
                    .font(.caption)
                Text("Lê Đình Đông")
                    .font(.footnote)
                    .fontWeight(.bold)
            }
            VStack{
                Text("Email")
                    .font(.caption)
                Text("dongldgcs190571@gmail.com")
                    .font(.footnote)
            }
            VStack{
                Text("Phone")
                    .font(.caption)
                Text("(84) 86 5663 278")
                    .font(.footnote)
                    .foregroundColor(Color.blue)
            }
            
            Text("Copyright © 2022 by Le Dinh Dong")
                .font(.caption)
                .fontWeight(.bold)
            
            Spacer()
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
