//
//  InfoView.swift
//  micard
//
//  Created by Richard Clifford on 24/02/2023.
//

import SwiftUI

struct InfoView: View {
    
    let text : String
    let imageName: String
    
    var body: some View {
        Capsule()
            .fill(Color.white)
            .frame(height: 48)
            .padding()
            .overlay(
                HStack {
                    Image(systemName: imageName)
                        .foregroundColor(Color(UIColor(red: 0.09, green: 0.63, blue: 0.52, alpha: 1.0)))
                    Text(text)
                }
                
            )
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "Hello World", imageName: "phone.fill")
            .previewLayout(.sizeThatFits)
    }
}
