//
//  AuthAppApp.swift
//  AuthApp
//
//  Created by Neal Archival on 7/12/22.
//

import SwiftUI

@main
struct AuthAppApp: App {
    @StateObject private var userData = UserData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userData)
        }
    }
}
