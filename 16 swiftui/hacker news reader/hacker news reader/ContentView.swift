//
//  ContentView.swift
//  hacker news reader
//
//  Created by Richard Clifford on 24/02/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(posts) { post in
                Text(post.title)
            }
            .navigationBarTitle("H4X0R News")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Post: Identifiable {
    let id: String
    let title: String
}

let posts = [
    Post(id: "1", title: "hello"),
    Post(id: "2", title: "bonjour"),
    Post(id: "3", title: "nihao"),
]
