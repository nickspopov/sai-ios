//
//  CommunityGraphQLImpl.swift
//  sai
//
//  Created by Николай Попов on 22.09.2023.
//

import Foundation
import SaiFastAPI

class CommunityGraphQLImpl: CommunityDataSource {
    func getAll() async throws -> [CommunityModel] {
        do {
            let result = try await Network.shared.apollo.fetchSingle(query: GetCommunitiesQuery(), cachePolicy: .fetchIgnoringCacheData)
            return result.getCommunities.map { $0.toSwiftModel() }
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    }
    
    func getAllCached() async -> [CommunityModel] {
        let result = await Network.shared.apollo.getCachedQuery(query: GetCommunitiesQuery())
        return result?.getCommunities.map { $0.toSwiftModel() } ?? []
    }
    
    func getBy(id: String) async throws -> CommunityModel {
        do {
            let result = try await Network.shared.apollo.fetchSingle(query: GetCommunityQuery(id: id), cachePolicy: .fetchIgnoringCacheData)
            return result.getCommunity.toSwiftModel()
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    }
    
    func getByCached(id: String) async -> CommunityModel? {
        let result = await Network.shared.apollo.getCachedQuery(query: GetCommunityQuery(id: id))
        return result?.getCommunity.toSwiftModel()
    }
    
    func save(community: CommunityModel) async throws -> CommunityModel {
        do {
            let result = try await Network.shared.apollo.perform(mutation: CreateCommunityMutation(name: community.name))
            return result.createCommunity.toSwiftModel()
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    }
    
    func save(place: CommunityPlace, for communityId: String) async throws -> CommunityModel {
        do {
            let result = try await Network.shared.apollo.perform(mutation: CreateCommunityPlaceMutation(input: CommunityPlaceInput(communityId: communityId, name: place.name, lat: place.lat!, lon: place.lon!)))
            return result.createCommunityPlace.toSwiftModel()
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    
    }
    
    func saveCheckin(in community: CommunityModel, for place: CommunityPlace, date: Date) async throws -> CommunityModel {
        do {
            let result = try await Network.shared.apollo.perform(mutation: CheckinCommunityPlaceMutation(communityId: community.id, placeId: place.id, date: date.ISO8601Format()))
            return result.checkinCommunityPlace.toSwiftModel()
        } catch {
            throw RepositoryError.somethingWentWrong
        }
    }
    
}
