//
//  PhoneVerificationView.swift
//  mobile
//
//  Created by Muhittin Koybasi on 18.11.2023.
//

import SwiftUI

struct PhoneVerificationView: View {
    @State var phone = ""
    @State var verificationCode = ""
    @State var isVerified = false
    
    var body: some View {
        VStack{
            TextField("Enter your phone number", text: $phone)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
                .border(phone.isEmpty ? .black : .accentColor)
            Button() {
                sendCode()
            } label: {
                Text("Send Code")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 40)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            }
            Spacer()
            TextField("Enter your verification code", text: $verificationCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 150)
                .border(verificationCode.isEmpty ? .black : .accentColor)
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
    }}

#Preview {
    PhoneVerificationView()
}
