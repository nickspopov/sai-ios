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
        request.addHeader(name: "Authorization", value: "64eb42c7b7c18dad6bc17185")
        
        chain.proceedAsync(request: request,
                            response: response,
                            completion: completion)
    }
    
}
