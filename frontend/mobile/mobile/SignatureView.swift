//
//  SignatureView.swift
//  mobile
//
//  Created by Muhittin Koybasi on 18.11.2023.
//

import SwiftUI

import Aleo

struct SignatureView: View {
    
    var signature: String
    
    var body: some View {
        VStack {
            Text("You just verified that you are the owner of given informaitions.. Here is your signature: ")
            Spacer()
            Text("sign1rax7eaj4ha3zvkacwxn7yt50rgynwdjfnn9ag67jvgm6zncfhvqsqyhexdl2kz0gh0qrv4myw7t7fml7vj7ymxxxde2zlgmfynjkkqhwgfpvvcn873tmcpca5gqz7lw9sqyewk5gw5ryezv7udsg3tp8puxd0334w2vnghvkcmstcyyqv7hkpedy4l0e87vsukg6c7ng6v9qqwa38kp")
                .padding(20)
            Spacer()
        }
    }
}

#Preview {
    SignatureView(signature: .init(""))
}
