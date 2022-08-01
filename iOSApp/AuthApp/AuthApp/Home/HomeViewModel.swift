//
//  HomeViewModel.swift
//  AuthApp
//
//  Created by Neal Archival on 7/14/22.
//

import Foundation

extension HomeView {
    @MainActor class ViewModel: ObservableObject {
        @Published var userData: UserData?
        
        @Published var user_id: Int = 0
        
        // Display variables
        @Published var username: String = ""
        @Published var location: String = ""
        
        @Published var errorMessage: String = ""
        
        func initUserData(_ ud: UserData) {
            self.userData = ud
        }
        
        func getUserData() async {
            do {
                let responseData = try await HomeService().fetchUserData(authToken: userData!.authToken)
                
                self.userData!.user_id = responseData.user_id
                self.userData!.username = responseData.username
                self.userData!.location = responseData.location
                
            } catch let error {
//                print("Error obtaining data")
                print(error.localizedDescription)
                if type(of: error) == HomeService.self.FetchUserDataError {
                    errorMessage = "Could not obtain user message"
                } else {
                    errorMessage = "Internal error"
                }
            }
        }
        
        func updateDisplay() {
            self.user_id = self.userData!.user_id
            self.username = self.userData!.username
            self.location = self.userData!.location
        }
        
        func logout() {
            self.userData!.authToken = "" // Reset authToken
        }
 
    }
}
