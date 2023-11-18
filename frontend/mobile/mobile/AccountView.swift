//
//  AccountView.swift
//  mobile
//
//  Created by Muhittin Koybasi on 18.11.2023.
//

import SwiftUI

import SwiftDate

import SwiftUI
import IGIdenticon


struct AccountView: View {
    @Environment(AccountData.self) var accountData
    
    let image = Identicon().icon(from: "string", size: CGSize(width: 100, height: 100))

    
    var body: some View {
        @Bindable var accountData = accountData
        
        VStack(spacing: 5.0){
            Text("Your Aleo Account")
                .font(.title)
                .padding()
            TextField("Enter your private key", text: $accountData.account.privateKey)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
                .border(accountData.account.privateKey.isEmpty ? .black : .accentColor)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .frame(width: 300)
              .border(accountData.account.privateKey.isEmpty ? .black : .accentColor)
              
            TextField("Enter your view key", text: $accountData.account.viewKey)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
                .border(accountData.account.viewKey.isEmpty ? .black : .accentColor)
            TextField("Enter your address", text: $accountData.account.address)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300)
                .border(accountData.account.address.isEmpty ? .black : .accentColor)
        }
    }
}


#Preview {
    AccountView()
        .environment(LocalAuthenticator())
        .environment(AleoManager())
        .environment(AccountData())
}

