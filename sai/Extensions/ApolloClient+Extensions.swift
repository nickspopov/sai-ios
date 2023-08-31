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
    
    
    public func fetchSingle<Query: GraphQLQuery>(
      query: Query,
      cachePolicy: CachePolicy = .default,
      contextIdentifier: UUID? = nil,
      queue: DispatchQueue = .global(qos: .userInitiated)
    ) async throws -> Query.Data {
        try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<Query.Data, Error>) -> Void in
            _ = fetch(
                query: query,
                cachePolicy: cachePolicy,
                contextIdentifier: contextIdentifier,
                queue: queue
            ) { response in
                switch response {
                case .success(let result):
                    if let data = result.data {
                        continuation.resume(returning: data)
                    } else {
                        continuation.resume(throwing: result.errors!.first!)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
    }
    
    public func getCachedQuery<Query: GraphQLQuery>(
        query: Query,
        queue: DispatchQueue = .global(qos: .userInitiated)
    ) async -> Query.Data? {
        await withCheckedContinuation({ (continuation: CheckedContinuation<Query.Data?, Never>) -> Void in
            Network.shared.apollo.store.withinReadTransaction({ transaction in
              let result = try? transaction.read(
                query: query
              )
                if result != nil {
                    continuation.resume(returning: result)
                } else {
                    continuation.resume(returning: nil)
                }
            })
        })
    }
    
    
    func perform<Mutation: GraphQLMutation>(mutation: Mutation) async throws
        -> Mutation.Data
    {
        try await withCheckedThrowingContinuation { continuation in
            _ = perform(mutation: mutation, publishResultToStore: false) { response in
                switch response {
                case .success(let result):
                    if let data = result.data {
                        continuation.resume(returning: data)
                    } else {
                        continuation.resume(throwing: result.errors!.first!)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
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
