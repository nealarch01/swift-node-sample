//
//  HomeView.swift
//  AuthApp
//
//  Created by Neal Archival on 7/14/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ViewModel() // Updates the view when something is changed
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack {
            PageHeader(titleName: "Home")
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("User ID:")
                            .font(.system(size: 20, weight: .bold))
                        Text("\(viewModel.user_id)")
                            .font(.system(size: 20))
                    }
                    HStack {
                        Text("Username:")
                            .font(.system(size: 20, weight: .bold))
                        Text("\(viewModel.username)")
                            .font(.system(size: 20))
                    }
                    HStack {
                        Text("Location:")
                            .font(.system(size: 20, weight: .bold))
                        Text("\(viewModel.location)")
                            .font(.system(size: 20))
                    }
                }.padding([.leading], 40)
                Spacer()
            }
            
            SubmitButton(text: "Logout", submitAction: viewModel.logout)
                .padding([.top], 15)
            
            Spacer()
        }.onAppear {
            viewModel.initUserData(userData)
            Task {
                await viewModel.getUserData()
                viewModel.updateDisplay()
            }
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
