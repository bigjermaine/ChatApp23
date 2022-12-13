//
//  MessageField.swift
//  ChatApp
//
//  Created by Apple on 25/09/2022.
//

import SwiftUI

struct MessageField: View {
    
    @State private var message = ""

    @EnvironmentObject var messagesManager: MessagesManager

    var body: some View {VStack {
        HStack {
            CustomTextField(placeholder: Text("Enter your message here"), text: $message)
                .frame(height: 52)
                .disableAutocorrection(true)
            
            
            Button {
                messagesManager.sendMessage(text: message)
                message = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color("Peach"))
                    .cornerRadius(50)
            }

        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(.gray)
        .cornerRadius(50)
        .padding()
    }
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField().environmentObject(MessagesManager())
    }
}
