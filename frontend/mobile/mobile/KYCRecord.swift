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
    var address: String
    var birthDate: Date
    var name: String
    var surname: String

    
    init(identity: String, address: String, birthDate: Date, name: String, surname: String) {
        self.id = UUID()
        self.identity = identity
        self.address = address
        self.birthDate = birthDate
        self.name = name
        self.surname = surname
    }
}

@Model
@Codable
final class Email: Codable {
    var email: String
    var isVerified: Bool

    
    init(email: String, isVerified: Bool) {
        self.email = email
        self.isVerified = isVerified
    }
}

@Model
@Codable
final class PhoneNumber: Codable {
    var phoneNumber: String
    var isVerified: Bool

    
    init(phoneNumber: String, isVerified: Bool) {
        self.phoneNumber = phoneNumber
        self.isVerified = isVerified
    }
}

@Model
@Codable
final class TwitterAccount: Codable {
    var handle: String
    var isVerified: Bool

    
    init(handle: String, isVerified: Bool) {
        self.handle = handle
        self.isVerified = isVerified
    }
}

@Model
@Codable
final class GithubAccount: Codable {
    var handle: String
    var isVerified: Bool

    
    init(handle: String, isVerified: Bool) {
        self.handle = handle
        self.isVerified = isVerified
    }
}








