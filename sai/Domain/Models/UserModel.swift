//
//  User.swift
//  sai
//
//  Created by Николай Попов on 04.09.2023.
//

import Foundation

struct UserModel {
    var id: String = UUID().uuidString
    var name: String
    var dogs: [DogModel]
}


