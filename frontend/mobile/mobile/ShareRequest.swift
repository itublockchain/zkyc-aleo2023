//
//  ShareRequest.swift
//  mobile
//
//  Created by Muhittin Koybasi on 18.11.2023.
//

import Foundation

import Aleo

struct ShareRequest: Identifiable, Codable {
    var id: UUID = .init()
    var source: String
    var date: Date
}

