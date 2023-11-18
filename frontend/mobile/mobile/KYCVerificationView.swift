//
//  KYCVerificationView.swift
//  mobile
//
//  Created by Muhittin Koybasi on 18.11.2023.
//

import SwiftUI

struct KYCVerificationView: View {
    @State var name = ""
    @State var surname = ""
    @State var id = ""
    @State var address = ""
    @State var isVerified = false
    
    var body: some View {
        VStack{
            TextField("Your name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
                .border(name.isEmpty ? .black : .accentColor)
            TextField("Your surname", text: $surname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
                .border(surname.isEmpty ? .black : .accentColor)
            TextField("Your id", text: $id)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
                .border(id.isEmpty ? .black : .accentColor)
            TextField("Your address", text: $address)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
                .border(address.isEmpty ? .black : .accentColor)
           
            if !isVerified {
                Button(action: verify) {
                    Text("Verify")
                }
            } else {
                Text("Verified")
            }
        }.frame(height: 240)
        
    }
    
    func sendCode() {
        
    }
    
    func verify() {
        
        isVerified = true
    }
}

#Preview {
    KYCVerificationView()
}
