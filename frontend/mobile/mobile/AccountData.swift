//
//  AccountData.swift
//  mobile
//
//  Created by Muhittin Koybasi on 18.11.2023.
//

import Foundation

@Observable
class AccountData {
    var account: AccountInput = AccountInput(privateKey: "", viewKey: "", address: "", accountName: "")
}
