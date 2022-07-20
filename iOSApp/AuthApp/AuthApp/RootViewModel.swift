//
//  RootViewModel.swift
//  AuthApp
//
//  Created by Neal Archival on 7/18/22.
//

import Foundation

extension RootView {
    @MainActor class ViewModel {
        @Published var userData: UserData?
        
        func initUserData(_ ud: UserData) {
            self.userData = ud
        }
    }
}
