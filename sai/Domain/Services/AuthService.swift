//
//  AuthService.swift
//  sai
//
//  Created by Николай Попов on 04.09.2023.
//

import Foundation
import FirebaseAuth

struct AuthActionError: Error {
    var reason: Reason
    
    enum Reason {
        case notAuthenticated
        case invalidEmail
        case invalidPassword
        case custom(String)
    }
}

protocol AuthService {
    func signIn(email: String, password: String) async -> Result<AuthUser, AuthActionError>
    func signUp(email: String, password: String) async -> Result<AuthUser, AuthActionError>
    func checkAuthStatusOptimistic() -> Bool
    func getCurrentUser() async -> AuthUser?
    func getToken() async -> String?
    func signOut() -> Void
}

class AuthServiceFirebaseImpl: AuthService {
    let auth = Auth.auth()
    
    func signIn(email: String, password: String) async -> Result<AuthUser, AuthActionError> {
        return await withCheckedContinuation { continuation in
            auth.signIn(withEmail: email, password: password) { [weak self] result, error in
                guard let self = self else { return }
                
                if let error = error {
                    continuation.resume(returning: .failure(AuthActionError(reason: .custom(error.localizedDescription))))
                } else if let result = result {
                    continuation.resume(returning: .success(authUser(from: result.user)))
                } else {
                    continuation.resume(returning: .failure(AuthActionError(reason: .notAuthenticated)))
                }
            }
        }
    }
    
    func signUp(email: String, password: String) async -> Result<AuthUser, AuthActionError> {
        return await withCheckedContinuation { continuation in
            auth.createUser(withEmail: email, password: password) { [weak self] result, error in
                guard let self = self else { return }
                
                if let error = error {
                    continuation.resume(returning: .failure(AuthActionError(reason: .custom(error.localizedDescription))))
                } else if let result = result {
                    continuation.resume(returning: .success(authUser(from: result.user)))
                } else {
                    continuation.resume(returning: .failure(AuthActionError(reason: .notAuthenticated)))
                }
            }
        }
    }
    
    func checkAuthStatusOptimistic() -> Bool {
        return auth.currentUser != nil
    }
    
    func getCurrentUser() async -> AuthUser? {
        if let currentUser = auth.currentUser {
            return authUser(from: currentUser)
        }
        return nil
    }
    
    func getToken() async -> String? {
        return await withCheckedContinuation { continuation in
            auth.currentUser?.getIDTokenForcingRefresh(false) { token, error in
                if let _ = error {
                    continuation.resume(returning: nil)
                } else if let token = token {
                    continuation.resume(returning: token)
                }
                continuation.resume(returning: nil)
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
    }
    
    private func authUser(from firebaseUser: User) -> AuthUser {
        return AuthUser(email: firebaseUser.email ?? "", displayName: firebaseUser.displayName)
    }
    
    static let shared = AuthServiceFirebaseImpl()
    private init() {}
}
