//
//  CommunityRepositoryImpl.swift
//  sai
//
//  Created by Николай Попов on 22.09.2023.
//

import Foundation


class CommunityRepositoryImpl: CommunityRepository {
    let graphQLDataSource: CommunityDataSource = CommunityGraphQLImpl()
    
    func getAll() async throws -> [CommunityModel] {
        return try await graphQLDataSource.getAll()
    }
    
    func getAllCached() async -> [CommunityModel] {
        return await graphQLDataSource.getAllCached()
    }
    
    func getBy(id: String) async throws -> CommunityModel {
        return try await graphQLDataSource.getBy(id: id)
    }
    
    func getByCached(id: String) async -> CommunityModel? {
        return await graphQLDataSource.getByCached(id: id)
    }
    
    func save(community: CommunityModel) async throws -> CommunityModel {
        return try await graphQLDataSource.save(community: community)
    }
    
    func save(place: CommunityPlace, for communityId: String) async throws -> CommunityModel {
        return try await graphQLDataSource.save(place: place, for: communityId)
    }
    
    func saveCheckin(in community: CommunityModel, for place: CommunityPlace, date: Date) async throws -> CommunityModel {
        return try await graphQLDataSource.saveCheckin(in: community, for: place, date: date)
    }
    
    private init() {}
    static let shared = CommunityRepositoryImpl()

}
