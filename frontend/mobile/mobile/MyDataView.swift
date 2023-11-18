//
//  MyDataView.swift
//  mobile
//
//  Created by Muhittin Koybasi on 18.11.2023.
//

import SwiftUI

import SwiftDate

struct MyDataView: View {
    
    @Environment(AleoManager.self) var aleoManager
    @Environment(AccountData.self) var accountData
    
    var name = "Jon"
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome, \((accountData.account.address) ?? "Jon")")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                NavigationLink(destination: EmailVerificationView()) {
                    Text("Verify Email")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: PhoneVerificationView()) {
                    Text("Verify Phone Number")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                NavigationLink(destination: KYCVerificationView()) {
                    Text("Verify KYC")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                NavigationLink(destination: TwitterVerificationView()) {
                    Text("Verify Twitter")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                NavigationLink(destination: GithubVerificationView()) {
                    Text("Verify Github")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
               
                NavigationLink(destination: SignatureView(signature: "asdf")) {
                    Text("Generate ZK Proof")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 250, height: 40)
                        .background(.green)
                        .cornerRadius(10)
                }
            }
        }
    }
    
    func deleteRequest(_ indexSet: IndexSet?) {
        
    }
}

#Preview {
    MyDataView()
        .modelContainer(for: [KYCRecord.self, PhoneNumber.self, Email.self, TwitterAccount.self, GithubAccount.self], inMemory: true)
        .environment(LocalAuthenticator())
        .environment(AleoManager())
        .environment(AccountData())
}

