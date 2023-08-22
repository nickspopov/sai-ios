//
//  NavigationController.swift
//  iosApp
//
//  Created by Николай Попов on 07.07.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI

enum Route: Hashable {
    case home
}


class NavigationController: ObservableObject {
    @Published var stack: [Route] = []
    
    func push(to: Route) {
        stack.append(to)
    }
    
    func pop() {
        stack.removeLast()
    }
}
