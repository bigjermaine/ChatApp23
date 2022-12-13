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
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(messagesManager.messages, id: \.id) { message in
                        MessageBubble(message: message)
                            .environmentObject(messagesManager)
                    }
                }
                
                .padding(.top, 10)
                .background(.white)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                MessageField()
            .onChange(of: messagesManager.lastMessageId) { id in
                withAnimation {
                    proxy.scrollTo(id, anchor:.bottom)
                }
            }
                .padding(.top, 10)
                .background(.blue.opacity(0.5       ))
            }
        }
    }
    
}
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
