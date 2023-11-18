//
//  TwitterVerificationView.swift
//  mobile
//
//  Created by Muhittin Koybasi on 18.11.2023.
//

import SwiftUI

struct TwitterVerificationView: View {
    @State private var buttonColor: Color = .blue
    @State private var buttonText: String = "Sign in with Twitter"
    
    var body: some View {
        
        Button(action: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    self.buttonColor = .green
                    self.buttonText = "@koybasimuhittin"
                }
            }
                   
               }) {
                   Text(buttonText)
                       .frame(width: 200, height: 50)
                       .background(buttonColor)
                       .foregroundColor(.white)
                       .cornerRadius(10)
               }
        
    }
}

#Preview {
    TwitterVerificationView()
}
