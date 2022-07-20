//
//  RegisterViewModel.swift
//  AuthApp
//
//  Created by Neal Archival on 7/12/22.
//

import Foundation

extension RegisterView {
    @MainActor class ViewModel: ObservableObject {
        @Published var userData: UserData?
        
        // Input variables
        @Published var username: String = ""
        @Published var password: String = ""
        @Published var confirmedPassword: String = ""
        @Published var location: String = ""
        
        @Published var errorMessage: String = ""
        
        func initUserData(_ ud: UserData) {
            self.userData = ud
        }
        
        func attemptCreateAccount() async {
            if password != confirmedPassword {
                errorMessage = "Passwords do not match"
                return
            }
            // Do regular expression checking
            let validator = InputValidator()
                
            if validator.validateUsername(username: username) == false {
                errorMessage = "Invalid username. Username must be at least 6 characters and can only contain alphanumeric characters and at least one alphabet character"
                return
            }
            
            if validator.validatePassword(password: password) == false {
                errorMessage = "Invalid password. Password must be at least 6 characters. Only symbols allowed: !,@,#,$,%,^,&,*,(,),{,},<,>,.,;"
            }
            
            if location != "" {
                if validator.validateLocation(location: location) == false {
                    errorMessage = "Invalid location entered"
                }
            }
            
            do {
                let authToken = try await AuthenticationModel().registerAccount(username, password, location)
                self.userData!.authToken = authToken
            } catch let error {
                print(error.localizedDescription)
                if type(of: error) == AuthenticationModel.self.AuthenticationError.self {
                    print("API Call Error")
                    errorMessage = error.localizedDescription
                } else {
                    print("SwiftUI Error")
                    errorMessage = "The application encountered an error"
                }
            }
        }
        
    }
}
