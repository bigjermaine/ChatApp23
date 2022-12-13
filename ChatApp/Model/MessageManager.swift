//
//  MessageManager.swift
//  ChatApp
//
//  Created by Apple on 25/09/2022.
//


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class MessagesManager: ObservableObject {
    
    
    @Published private(set) var lastMessageId: String = ""

    
    @Published private(set) var messages: [Message] = []
    let db = Firestore.firestore()
    
    
    
    init() {
        getMessages()
    }
    func getMessages() {
        db.collection("messages").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            self.messages = documents.compactMap { document -> Message? in
                do {
                    return try document.data(as: Message.self)
                } catch {
                    print("Error decoding document into Message: \(error)")
                    return nil
                }
            }
            self.messages.sort { $0.timestamp <  $1.timestamp } 
        }
    }
    func sendMessage(text: String) {
        do {
            let newMessage = Message(id: "\(UUID())", text: text, received: true, timestamp: Date())

            try db.collection("messages").document().setData(from: newMessage)
        } catch {
            print("Error adding message to Firestore: \(error)")
        }
        
        
        if let id = self.messages.last?.id {
                self.lastMessageId = id
        }
    }
}
