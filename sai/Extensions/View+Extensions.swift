//
//  View+IsVisble.swift
//  iosApp
//
//  Created by Николай Попов on 17.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI

struct IsVisibleModifier : ViewModifier{
    
     var isVisible : Bool
    // the transition will add a custom animation while displaying the
    // view.
    var transition : AnyTransition

    func body(content: Content) -> some View {
        ZStack{
            if isVisible{
                content
                    .transition(transition)
            }
        }
    }
}

extension View {

    func isVisible(
        isVisible : Bool,
        transition : AnyTransition = .scale
    ) -> some View{
        modifier(
            IsVisibleModifier(
                isVisible: isVisible,
                transition: transition
            )
        )
    }
}


extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
