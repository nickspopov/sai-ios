//
//  UserDataSource.swift
//  sai
//
//  Created by Николай Попов on 04.09.2023.
//

import Foundation

protocol UserDataSource {
    func getMe() async throws -> UserModel
}
