//
//  LoginView.swift
//  AuthApp
//
//  Created by Neal Archival on 7/12/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userData: UserData
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            PageHeader(titleName: "Login")
            CaptionedTextField(caption: "Username", text: $viewModel.username, placeholder: "Enter username")
                .padding([.top], 20)
            ViewableSecureField(caption: "Password", text: $viewModel.password, placeholder: "Enter password")
                .padding([.top], 5)
            if viewModel.errorMessage != "" {
                Text(viewModel.errorMessage)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color.red)
            }
            SubmitButton(text: "Login", submitAction: viewModel.attemptLogin)
                .padding([.top], 7)
        }.onAppear {
            viewModel.initUserData(userData)
        }.fullScreenCover(isPresented: $viewModel.isLoading) {
            ZStack {
                Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
                ProgressView()
            }
            .background(BlurredBackground())
        }.onAppear { // Belongs to fullScreenCover
            UIView.setAnimationsEnabled(false)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
