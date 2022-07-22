//
//  RegisterView.swift
//  AuthApp
//
//  Created by Neal Archival on 7/12/22.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject var userData: UserData
    var body: some View {
        VStack {
            PageHeader(titleName: "Sign Up")
            CaptionedTextField(caption: "Username", text: $viewModel.username, placeholder: "Enter a username")
            ViewableSecureField(caption: "Password", text: $viewModel.password, placeholder: "Enter a password")
            ViewableSecureField(caption: "Confirm Password", text: $viewModel.confirmedPassword, placeholder: "Enter password again")
            CaptionedTextField(caption: "Location (City)", text: $viewModel.location, placeholder: "Enter location (optional)")
            if viewModel.errorMessage != "" {
                Text(viewModel.errorMessage)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color.red)
                    
            }
            SubmitButton(text: "Create Account", submitAction: viewModel.attemptCreateAccount)
        }
        .onAppear {
            viewModel.initUserData(userData)
        }
        .fullScreenCover(isPresented: $viewModel.isLoading) {
            ZStack {
                Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
                ProgressView()
            }
            .background(BlurredBackground())
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
