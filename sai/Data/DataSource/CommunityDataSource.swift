//
//  CommunityDataSource.swift
//  sai
//
//  Created by Николай Попов on 22.09.2023.
//

import Foundation


protocol CommunityDataSource {
    // CRUD
    func getAll() async throws -> [CommunityModel]
    func getAllCached() async -> [CommunityModel]
    func getBy(id: String) async throws -> CommunityModel
    func getByCached(id: String) async -> CommunityModel?
    func save(community: CommunityModel) async throws -> CommunityModel
    func save(place: CommunityPlace, for communityId: String) async throws -> CommunityModel
    func saveCheckin(in: CommunityModel, for: CommunityPlace, date: Date) async throws -> CommunityModel
}
