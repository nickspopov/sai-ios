//
//  ScreenPositionKey.swift
//  sai
//
//  Created by Николай Попов on 05.09.2023.
//

import SwiftUI

struct ScreenPositionKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
