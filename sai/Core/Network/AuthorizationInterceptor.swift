//
//  AuthorizationInterceptor.swift
//  sai
//
//  Created by Николай Попов on 28.08.2023.
//

import Foundation
import Apollo
import ApolloAPI

class AuthorizationInterceptor: ApolloInterceptor {
    var id: String = "AuthorizationInterceptor"
    
    func interceptAsync<Operation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) where Operation : GraphQLOperation {
        Task {
            if let token = await AuthServiceFirebaseImpl.shared.getToken() {
                request.addHeader(name: "Authorization", value: token)
            }
            chain.proceedAsync(request: request,
                                response: response,
                                completion: completion)
        }
    }
    
}
