//
//  SignatureView.swift
//  mobile
//
//  Created by Muhittin Koybasi on 18.11.2023.
//

import SwiftUI

import Aleo

struct SignatureView: View {
    
    var source: String
    var signature: Signature
    
    var body: some View {
        VStack {
            Text("You just shared your medical records with \(source). Here is your signature: ")
            Spacer()
            Text(signature.toString())
                .padding(20)
            Spacer()
        }
    }
}

#Preview {
    SignatureView(source: "Aetna", signature: .init(""))
}
