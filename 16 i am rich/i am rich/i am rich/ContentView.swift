//
//  ContentView.swift
//  i am rich
//
//  Created by Richard Clifford on 23/02/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.systemTeal)
                .edgesIgnoringSafeArea(Edge.Set.all)
            VStack {
                Image("diamond")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200, alignment: .center)
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("I am Rich").font(.system(size: 40)).fontWeight(.bold).foregroundColor(Color.white)
                
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice(PreviewDevice(rawValue: "iPhone 14"))
        
    }
}
