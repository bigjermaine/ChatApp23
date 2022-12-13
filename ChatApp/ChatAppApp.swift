//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Apple on 13/12/2022.
//

import SwiftUI

@main
struct ChatAppApp: App {
    
    var body: some Scene {
        
        
        init() {
            FirebaseApp.configure()
        }

        WindowGroup {
            ContentView()
        }
    }
}
