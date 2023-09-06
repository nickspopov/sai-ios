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

extension View {
    func screenContainer() -> some View {
        return self
            .preferredColorScheme(.dark)
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity,
                  alignment: .center
            )
            .background(.black)
    }
}


struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}


extension View {
    func pressable(_ action: @escaping () -> Void) -> some View {
        self.onTapGesture(perform: action)
    }
}


extension View {
    @ViewBuilder
    func screenPositionYChangePreference(completion: @escaping (CGFloat) -> ()) -> some View {
        self
            .overlay {
                GeometryReader(content: { geometry in
                    Color.clear
                        .preference(key: ScreenPositionKey.self, value: geometry.frame(in: .global).minY)
                        .onPreferenceChange(ScreenPositionKey.self, perform: { value in
                            completion(value)
                        })
                })
            }
    }
}
