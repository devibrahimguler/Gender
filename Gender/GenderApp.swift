//
//  GenderApp.swift
//  Gender
//
//  Created by İbrahim Güler on 30.06.2023.
//

import SwiftUI
import Firebase

@main
struct GenderApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
