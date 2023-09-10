//
//  IsVisibleModifier.swift
//  sai
//
//  Created by Николай Попов on 10.09.2023.
//

import Foundation
import SwiftUI

struct IsVisibleModifier : ViewModifier{
    
    var isVisible : Bool
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
