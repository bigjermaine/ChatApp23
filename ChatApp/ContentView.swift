//
//  ContentView.swift
//  ChatApp
//
//  Created by Apple on 13/12/2022.
//

import SwiftUI

struct ContentView: View {
    var messagesArray = ["Hello you", "How are you doing?", "I wanted to let you know that I've been building SwiftUI applications from scratch", "And it's so much fun!"]
    var body: some View {
        VStack{
            TitleRow()
            ScrollView {
                ForEach(messagesArray, id: \.self) { text in
                    MessageBubble(message: Message(id: "12345", text: text, received: true, timestamp: Date()))
                }
            }
            
            .padding(.top, 10)
            .background(.white)
            .cornerRadius(30, corners: [.topLeft, .topRight])
            MessageField()
                

        }
        
        .padding(.top, 10)
        .background(.blue.opacity(0.5       ))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
