//
//  MemoryCapsuleApp.swift
//  MemoryCapsule
//
//  Created by Gourav Kumar on 26/03/25.
//

import SwiftUI
import FirebaseCore


@main
struct MemoryCapsuleApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
