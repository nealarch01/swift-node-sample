//
//  AuthenticationService.swift
//  AuthApp
//
//  Created by Neal Archival on 7/16/22.
//

import Foundation

fileprivate struct LoginResponse: Decodable {
    let status_code: Int
    let token: String?
    let message: String?
}

fileprivate struct RegisterResponse: Decodable {
    let status_code: Int
    let token: String?
    let message: String?
}

fileprivate struct LoginBodyParams: Codable {
    let username: String
    let password: String
    
    init(_ username: String, _ password: String) {
        self.username = username
        self.password = password
    }
}

fileprivate struct RegisterBodyParams: Codable {
    let username: String
    let password: String
    let location: String
    
    init(_ username: String, _ password: String, _ location: String) {
        self.username = username
        self.password = password
        self.location = location
    }
}

class AuthenticationService {
    public func login(_ username: String, _ password: String) async throws -> String {
        let apiEndpoint = URL(string: "http://127.0.0.1:1234/auth/login")!
        
        var request = URLRequest(url: apiEndpoint)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bodyParams = LoginBodyParams(username, password)
        
        let bodyData = try JSONEncoder().encode(bodyParams)
        
        request.httpBody = bodyData
        
        let session = URLSession.shared
        
        let (responseData, _) = try await session.data(for: request)

        let decoded = try JSONDecoder().decode(LoginResponse.self, from: responseData)

        if decoded.status_code != 200 {
            throw AuthenticationError(status_code: decoded.status_code, serverMessage: decoded.message!)
        }

        return decoded.token!
    }
    
    public func registerAccount(_ username: String, _ password: String, _ location: String) async throws -> String {
        // Regular expression checking should be done in the ViewModel of Register
        let apiEndpoint = URL(string: "http://127.0.0.1:1234/auth/register")!
        
        var request = URLRequest(url: apiEndpoint)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bodyParams = RegisterBodyParams(username, password, location)
        
        let bodyData = try JSONEncoder().encode(bodyParams)
        
        request.httpBody = bodyData
        
        let session = URLSession.shared
        
        let (responseData, _) = try await session.data(for: request)
        
        let decoded = try JSONDecoder().decode(RegisterResponse.self, from: responseData)
        
        if decoded.status_code != 201 {
            if decoded.message != nil {
                throw AuthenticationError(status_code: decoded.status_code, serverMessage: decoded.message!)
            }
            throw AuthenticationError(status_code: decoded.status_code, serverMessage: "Could not create account")
        }
        
        return decoded.token!
    }
    
    // Errors
    public struct AuthenticationError: LocalizedError {
        public let status_code: Int?
        public var errorDescription: String?
        
        init(status_code: Int, serverMessage: String) {
            self.status_code = status_code
            self.errorDescription = serverMessage
        }
    }
}



