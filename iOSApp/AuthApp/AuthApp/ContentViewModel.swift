//
//  ContentViewModel.swift
//  AuthApp
//
//  Created by Neal Archival on 7/12/22.
//

import Foundation


extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var userData = UserData()
    }
}
