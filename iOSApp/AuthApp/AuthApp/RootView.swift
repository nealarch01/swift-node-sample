//
//  RootView.swift
//  AuthApp
//
//  Created by Neal Archival on 7/18/22.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var userData: UserData
    var body: some View {
        if userData.authToken == "" {
            AuthenticationView()
        } else {
            HomeView()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
