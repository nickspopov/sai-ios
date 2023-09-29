//
//  UserGraphQLImpl.swift
//  sai
//
//  Created by Николай Попов on 04.09.2023.
//

import Foundation
import SaiFastAPI

class UserGrapQLImpl: UserDataSource {
    func getMe() async throws -> UserModel {
        let result = try await Network.shared.apollo.fetchSingle(query: GetMeQuery(), cachePolicy: .fetchIgnoringCacheData, queue: .global(qos: .userInitiated))
        return result.me.fragments.userFragment.toDomain()
    }
    
    func getMeCached() async -> UserModel? {
        let result = await Network.shared.apollo.getCachedQuery(query: GetMeQuery())
        return result?.me.fragments.userFragment.toDomain()
    }
}
