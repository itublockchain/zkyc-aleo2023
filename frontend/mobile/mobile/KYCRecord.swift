//
//  KYCRecord.swift
//  mobile
//
//  Created by Muhittin Koybasi on 18.11.2023.
//

import Foundation
import SwiftData

import SimpleCodable

@Model
@Codable
final class KYCRecord: Codable {
    var id: UUID
    
    var identity: String
    var phoneNumber: String
    var email: String
    var address: String
    var birthDate: Date
    var twitterHandle: String

    
    init(identity: String, phoneNumber: String, email: String, address: String, birthDate: Date, twitterHandle: String) {
        self.id = UUID()
        self.identity = identity
        self.phoneNumber = phoneNumber
        self.email = email
        self.address = address
        self.birthDate = birthDate
        self.twitterHandle = twitterHandle
    }
}




