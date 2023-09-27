//
//  View+IsVisble.swift
//  iosApp
//
//  Created by Николай Попов on 17.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import SwiftUI


// MARK: - Screen Container
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
    
    func screenContainer(background: some View) -> some View {
        return self
            .preferredColorScheme(.dark)
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
            )
            .background(background)
    }
}

// MARK: - Pressable
extension View {
    func pressable(_ action: @escaping () -> Void) -> some View {
        self.onTapGesture(perform: action)
    }
}

// MARK: - IsVisibleModifier
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

// MARK: - If Modifier
extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

// MARK: - Corner Radius
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCornerShape(radius: radius, corners: corners) )
    }
}

// MARK: - screenPositionYChangePreference
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


// MARK: - Will DisAppear
extension View {
    func lifecycle(onWillDisappear: (() -> Void)? = nil, onWillAppear: (() -> Void)? = nil, onDidDisappear: (() -> Void)? = nil, onDidAppear: (() -> Void)? = nil) -> some View {
        self.modifier(LifecycleModifier(
            onWillDisappear: onWillDisappear,
            onWillAppear: onWillAppear,
            onDidDisappear: onDidDisappear,
            onDidAppear: onDidAppear
        ))
    }
}


// MARK: - Highlight BG Debug Rerender
fileprivate var colors: [Color] = [.blue, .yellow, .green, .red, .brown, .cyan, .gray, .indigo, .mint, .pink, .orange]

extension View {
    func debugOnlyModifier<T: View>(_ modifier: (Self) -> T) -> some View {
#if DEBUG
        return modifier(self)
#else
        return self
#endif
    }
    
    func highlightBGDebugRerender() -> some View {
        debugOnlyModifier {
            $0.background(Rectangle().foregroundColor(colors.randomElement()))
        }
    }
}


// MARK: - Debug Frame
public extension View {
    
    /// Applies an overlay to your view and returns a new view. The overlay contains a border of your view, its origin, and size.
    /// - Parameter color: Default color for the border of the overlay and outputs.
    /// - Returns: View that uses the debug overlay.
    func debugFrame(color: Color = Color.red) -> some View {
        return modifier(
            DebugFrameModifier(
                color: color,
                outputs: [DebugFrameOutput.all]
            )
        )
    }
    
    /// Applies an overlay to your view and returns a new view. The overlay contains a border of your view, its origin, and size.
    /// - Parameters:
    ///   - color: Default color for the border of the overlay and outputs.
    ///   - outputs: Default outputs of the overlay such as origin and size.
    /// - Returns: View that uses the debug overlay.
    func debugFrame(color: Color = Color.red, _ outputs: DebugFrameOutput...) -> some View {
        return modifier(
            DebugFrameModifier(
                color: color,
                outputs: outputs.isEmpty ? [DebugFrameOutput.all] : outputs
            )
        )
    }
}
