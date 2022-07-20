//
//  AuthenticationView.swift
//  AuthApp
//
//  Created by Neal Archival on 7/12/22.
//

import SwiftUI

struct AuthenticationView: View {
    // Observed object to reinstantiate authentication view back to default state when logging out
    @ObservedObject var viewModel = ViewModel()
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack {
            if viewModel.activeScreen == .LOGIN {
                VStack {
                    LoginView()
                        .environmentObject(userData)
                    HStack {
                        Text("Don't have an account?")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color.black.opacity(0.7))
                        Button(action: changeScreen) {
                            Text("Sign Up")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color.green)
                        }
                    }
                }
            } else {
                RegisterView()
                HStack {
                    Text("Already have an account?")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.black.opacity(0.8))
                    
                    Button(action: changeScreen) {
                        Text("Sign In")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color.green)
                    }.padding([.leading], -2)
                }.padding([.top], 10)
            }
            Spacer()
        }.onAppear {
            self.viewModel.initUserData(userData)
        }
    }
    
    func changeScreen() {
        viewModel.switchScreen()
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
