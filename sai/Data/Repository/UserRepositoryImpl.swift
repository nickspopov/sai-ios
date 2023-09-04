//
//  UserRepositoryImpl.swift
//  sai
//
//  Created by Николай Попов on 04.09.2023.
//

import Foundation


class UserRepositoryImpl: UserRepository {
    
    private let userGraphQLSource: UserDataSource = UserGrapQLImpl()
    
    func getMe() async throws -> UserModel {
        try await userGraphQLSource.getMe()
    }
    
    
    private init() {}
    static let shared = UserRepositoryImpl()
}
