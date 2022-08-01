//
//  HomeModel.swift
//  AuthApp
//
//  Created by Neal Archival on 7/19/22.
//

import Foundation

fileprivate struct FetchUserDataParams: Codable {
    let token: String
    
    init(_ authToken: String) {
        self.token = authToken
    }
}

fileprivate struct UserDataResponse: Decodable {
    let status_code: Int
    let message: String?
    let user_id: Int?
    let username: String?
    let location: String?
}

class HomeService {
    public func fetchUserData(authToken: String) async throws -> UserData {
        let user_data = UserData()
        
        let apiEndpoint = URL(string: "http://127.0.0.1:1234/user")!
        var request = URLRequest(url: apiEndpoint)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bodyParams = FetchUserDataParams(authToken)
        
        let bodyData = try JSONEncoder().encode(bodyParams)
        
        request.httpBody = bodyData
        
        let session = URLSession.shared
        
        let (responseData, _) = try await session.data(for: request)
        
        let decoded = try JSONDecoder().decode(UserDataResponse.self, from: responseData)
        
        if decoded.status_code < 200 || decoded.status_code > 299 {
            if decoded.message == nil {
                throw FetchUserDataError(serverMessage: "An error has occured attempting to fetch data.")
            }
            throw FetchUserDataError(serverMessage: decoded.message!)
        }
        
        user_data.username = decoded.username!
        user_data.user_id = decoded.user_id!
        user_data.location = decoded.location!
    
        return user_data
    }
    
    public struct FetchUserDataError: LocalizedError {
        public var errorDescription: String?
        
        init(serverMessage: String) {
            self.errorDescription = serverMessage
        }
    }
}



