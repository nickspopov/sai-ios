//
//  CommunityModel.swift
//  sai
//
//  Created by Николай Попов on 22.09.2023.
//

import Foundation


struct CommunityModel {
    var id: String = UUID().uuidString
    var name: String
    var members: [CommunityMember]
    var places: [CommunityPlace]
}

struct CommunityPlace {
    var id: String
    var name: String
    var lat: Double?
    var lon: Double?
}

struct LastCheckinModel {
    var date: Date
    var place: CommunityPlace
}

struct CommunityMember {
    var user: UserModel
    var lastCheckin: LastCheckinModel?
}
