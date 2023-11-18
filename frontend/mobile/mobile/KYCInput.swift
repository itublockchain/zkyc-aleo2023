//
//  KYCInput.swift
//  mobile
//
//  Created by Muhittin Koybasi on 18.11.2023.
//

import SwiftUI

struct phone {
    @State var verifiedPhoneNumber: String
    @State var isVerified: Bool
    @State var currentlyEnteredPhoneNumber: String
    var option = 0
    var name = "Phone Number"

    init(){
        verifiedPhoneNumber = ""
        isVerified = false
        currentlyEnteredPhoneNumber = ""
    }

    func verify() -> Bool {
        // mock phone verification
        if currentlyEnteredPhoneNumber == "0" {
            verifiedPhoneNumber = currentlyEnteredPhoneNumber
            isVerified = true
            return true
        } else {
            return false
        }
    }
}

struct email {
    @State var verifiedEmail: String
    @State var isVerified: Bool
    @State var currentlyEnteredEmail: String
    var option = 1
    var name = "Email"

    init(){
        verifiedEmail = ""
        isVerified = false
        currentlyEnteredEmail = ""
    }

    func verify() -> Bool {
        // mock email verification
        if currentlyEnteredEmail == "1" {
            verifiedEmail = currentlyEnteredEmail
            isVerified = true
            return true
        } else {
            return false
        }
    }
}

struct address {
    @State var verifiedAddress: String
    @State var isVerified: Bool
    @State var currentlyEnteredAddress: String
    var option = 2
    var name = "Address"

    init(){
        verifiedAddress = ""
        isVerified = false
        currentlyEnteredAddress = ""
    }

    func verify() -> Bool {
        // mock address verification
        if currentlyEnteredAddress == "2" {
            verifiedAddress = currentlyEnteredAddress
            isVerified = true
            return true
        } else {
            return false
        }
    }
}

struct identity {
    @State var verifiedIdentity: String
    @State var isVerified: Bool
    @State var currentlyEnteredIdentity: String
    var option = 3
    var name = "Identity Number"

    init(){
        verifiedIdentity = ""
        isVerified = false
        currentlyEnteredIdentity = ""
    }

    func verify() -> Bool {
        // mock identity verification
        if currentlyEnteredIdentity == "3" {
            verifiedIdentity = currentlyEnteredIdentity
            isVerified = true
            return true
        } else {
            return false
        }
    }
}

struct KYCInput: View {
    private var emailVerification = email()
    private var addressVerification = address()
    private var identityVerification = identity()
     private var phoneVerification = phone()
    @State private var option = 0

    var body: some View {
        VStack {
            if (option >= phoneVerification.option){
                if(option > phoneVerification.option){
                    Text(phoneVerification.name + (phoneVerification.isVerified ?  " Verified" : " Passed"))
                        .font(.largeTitle)
                        .padding()
                }else {
                    Text(phoneVerification.name + " Verification")
                        .font(.largeTitle)
                        .padding()
                }
                if(option == phoneVerification.option && !phoneVerification.isVerified){
                    TextField("Enter Your " + phoneVerification.name, text: phoneVerification.$currentlyEnteredPhoneNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
            }
            if (option >= emailVerification.option){
                if(option > emailVerification.option){
                    Text(emailVerification.name + (emailVerification.isVerified ?  " Verified" : " Passed"))
                        .font(.largeTitle)
                        .padding()
                }else {
                    Text(emailVerification.name + " Verification")
                        .font(.largeTitle)
                        .padding()
                }
                if(option == emailVerification.option && !emailVerification.isVerified){
                    TextField("Enter Your " + emailVerification.name, text: emailVerification.$currentlyEnteredEmail)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
            }
            if (option >= addressVerification.option && !addressVerification.isVerified){
                if(option > addressVerification.option){
                    Text(addressVerification.name + (addressVerification.isVerified ?  " Verified" : " Passed"))
                        .font(.largeTitle)
                        .padding()
                }else {
                    Text(addressVerification.name + " Verification")
                        .font(.largeTitle)
                        .padding()
                }
                if(option == addressVerification.option){
                    TextField("Enter Your " + addressVerification.name, text: addressVerification.$currentlyEnteredAddress)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
            }
            if (option >= identityVerification.option && !identityVerification.isVerified){
                if(option > identityVerification.option){
                    Text(identityVerification.name + (identityVerification.isVerified ?  " Verified" : " Passed"))
                        .font(.largeTitle)
                        .padding()
                }else {
                    Text(identityVerification.name + " Verification")
                        .font(.largeTitle)
                        .padding()
                }
                if(option == identityVerification.option){
                    TextField("Enter Your " + identityVerification.name, text: identityVerification.$currentlyEnteredIdentity)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
            }
         

            HStack{
                Button("Back", systemImage: "arrow.left") {
                    if(option == 1){
                       option -= 1
                    }
                    else if(option == 2){
                        option -= 1
                    }
                    else if(option == 3){
                        option -= 1
                    }
                    
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                Button("Check") {
                    print(option)
                    if(option == emailVerification.option){
                        let isVerified = emailVerification.verify()
                        if(isVerified && option < 3) {
                            option = option + 1
                        }
                    }
                    else if(option == phoneVerification.option){
                        print(phoneVerification.currentlyEnteredPhoneNumber)
                        let isVerified = phoneVerification.verify()
                        if(isVerified && option < 3) {
                            option = option + 1
                        }
                    }
                    else if(option == addressVerification.option){
                        let isVerified = addressVerification.verify()
                        if(isVerified && option < 3) {
                            option = option + 1
                        }
                    }
                    else if(option == identityVerification.option){
                        let isVerified = identityVerification.verify()
                        if(isVerified && option < 3) {
                            option = option + 1
                        }
                    }
                    
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Pass") {
                    if(option == 0){
                       option += 1
                    }
                    else if(option == 1){
                        option += 1
                    }
                    else if(option == 2){
                        option += 1
                    }
                    
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
               
                
            }
           


        }
        .padding()
    }
}
