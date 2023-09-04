//
//  Dog.swift
//  sai
//
//  Created by Николай Попов on 04.09.2023.
//

import Foundation


struct DogModel {
    var id: String = UUID().uuidString
    var name: String
    var breed: String
    var sex: String
    var dateOfBirth: Date
}
