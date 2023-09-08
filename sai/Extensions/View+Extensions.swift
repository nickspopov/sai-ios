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

struct WillDisappearHandler: UIViewControllerRepresentable {
    func makeCoordinator() -> WillDisappearHandler.Coordinator {
        Coordinator(onWillDisappear: onWillDisappear)
    }

    let onWillDisappear: () -> Void

    func makeUIViewController(context: UIViewControllerRepresentableContext<WillDisappearHandler>) -> UIViewController {
        context.coordinator
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<WillDisappearHandler>) {
    }

    typealias UIViewControllerType = UIViewController

    class Coordinator: UIViewController {
        let onWillDisappear: () -> Void

        init(onWillDisappear: @escaping () -> Void) {
            self.onWillDisappear = onWillDisappear
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            onWillDisappear()
        }
    }
}

struct WillDisappearModifier: ViewModifier {
    let callback: () -> Void

    func body(content: Content) -> some View {
        content
            .background(WillDisappearHandler(onWillDisappear: callback))
    }
}

extension View {
    func onWillDisappear(_ perform: @escaping () -> Void) -> some View {
        self.modifier(WillDisappearModifier(callback: perform))
    }
}

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


private struct DebugFrame: ViewModifier {
    
    let color: Color
    let outputs: [DebugFrameOutput]
    
    func body(content: Content) -> some View {
        #if DEBUG
            content
                .overlay(
                    GeometryReader { geometry in
                        ZStack(alignment: .bottom) {
                            Rectangle()
                                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                .foregroundColor(color)
                            Text(defineOutput(with: geometry))
                                .foregroundColor(color)
                                .font(.caption2)
                        }
                    }
                )
        #else
            content
        #endif
    }
    
    private func defineOutput(with geometry: GeometryProxy) -> String {
        let globalOrigin: CGPoint = geometry.frame(in: .global).origin
        let originX: String = "x: \(rounded(globalOrigin.x))"
        let originY: String = "y: \(rounded(globalOrigin.y))"
        let width: String = "w: \(rounded(geometry.size.width))"
        let height: String = "h: \(rounded(geometry.size.height))"
        return String(
            outputs.reduce(into: String()) {
                switch $1 {
                case .all: $0 += "(\(originX), \(originY)) | (\(width), \(height))"
                case .origin: $0 += "(\(originX), \(originY))"
                case .size: $0 += "(\(width), \(height))"
                case .originX: $0 += originX
                case .originY: $0 += originY
                case .width: $0 += width
                case .height: $0 += height
                }
                $0 += " | "
            }.dropLast(3)
        )
    }
    
    private func rounded(_ value: CGFloat) -> Float {
        return Float(round(100 * value) / 100)
    }
}

public enum DebugFrameOutput {
    
    case all
    case origin, size
    case originX, originY
    case width, height
}

public extension View {
    
    /// Applies an overlay to your view and returns a new view. The overlay contains a border of your view, its origin, and size.
    /// - Parameter color: Default color for the border of the overlay and outputs.
    /// - Returns: View that uses the debug overlay.
    func debugFrame(color: Color = Color.red) -> some View {
        return modifier(
            DebugFrame(
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
            DebugFrame(
                color: color,
                outputs: outputs.isEmpty ? [DebugFrameOutput.all] : outputs
            )
        )
    }
}
