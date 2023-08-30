//
//  ApolloClient+Extensions.swift
//  sai
//
//  Created by Николай Попов on 30.08.2023.
//

import Foundation
import Apollo
import SaiFastAPI


extension ApolloClient {
  public func fetch<Query: GraphQLQuery>(
    query: Query,
    cachePolicy: CachePolicy = .default,
    contextIdentifier: UUID? = nil,
    queue: DispatchQueue = .global(qos: .userInitiated)
  ) -> AsyncThrowingStream<GraphQLResult<Query.Data>, Error> {
    AsyncThrowingStream { continuation in
      let request = fetch(
        query: query,
        cachePolicy: cachePolicy,
        contextIdentifier: contextIdentifier,
        queue: queue
      ) { response in
        switch response {
        case .success(let result):
          continuation.yield(result)
          if result.isFinalForCachePolicy(cachePolicy) {
            continuation.finish()
          }
        case .failure(let error):
          continuation.finish(throwing: error)
        }
      }
      continuation.onTermination = { @Sendable _ in request.cancel() }
    }
  }
}

extension GraphQLResult {
  func isFinalForCachePolicy(_ cachePolicy: CachePolicy) -> Bool {
    switch cachePolicy {
    case .returnCacheDataElseFetch:
      return true
    case .fetchIgnoringCacheData:
      return source == .server
    case .fetchIgnoringCacheCompletely:
      return source == .server
    case .returnCacheDataDontFetch:
      return source == .cache
    case .returnCacheDataAndFetch:
      return source == .server
    }
  }
}
