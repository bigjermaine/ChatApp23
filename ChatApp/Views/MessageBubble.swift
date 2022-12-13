//
//  MessageBubble.swift
//  ChatApp
//
//  Created by Apple on 24/09/2022.
//

import SwiftUI


struct MessageBubble: View {
    var message: Message
 
    @State private var showTime = false
    var body: some View {
        VStack(alignment: message.received ? .leading : .trailing) {
            HStack {
                Text(message.text)
                    .padding()
                    .background(message.received ? Color.green : Color.red)
                    .cornerRadius(30)
                
                
                if showTime {
                    Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(message.received ? .leading : .trailing, 25)
                }
            }
            .frame(maxWidth: 300, alignment: message.received ? .leading : .trailing)
            
        }
        .frame(maxWidth: .infinity, alignment: message.received ? .leading : .trailing)
        .padding(message.received ? .leading : .trailing)
        .padding(.horizontal, 10)
        .onTapGesture {
                showTime.toggle()
        }
    
        
    }
    
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(message: Message(id: "12345", text: "I've been coding applications from scratch in SwiftUI and it's so much fun!", received: true, timestamp: Date()))
    }
}
