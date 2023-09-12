//
//  NotificationService.swift
//  sai
//
//  Created by Николай Попов on 12.09.2023.
//

import Foundation
import SaiFastAPI

class NotificationService {
    func onGetNewToken(_ token: String) {
        Task {
            do {
                let _ = try await Network.shared.apollo.perform(mutation: SetPushTokenMutation(token: token))
            } catch {
                print("Send push token error \(error)")
            }
        }
    }
    
    static let shared = NotificationService()
    private init() {}
}
