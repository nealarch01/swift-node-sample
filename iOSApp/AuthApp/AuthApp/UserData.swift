//
//  UserData.swift
//  AuthApp
//
//  Created by Neal Archival on 7/16/22.
//

import Foundation

class UserData: ObservableObject {
    @Published var authToken: String = ""
    @Published var user_id: Int = 0
    @Published var username: String = ""
    @Published var location: String = ""
    
    func resetUserData() {
        authToken =  ""
        user_id = 0
        username = ""
        location = ""
    }
}
