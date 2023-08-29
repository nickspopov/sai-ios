//
//  CustomButton.swift
//  iosApp
//
//  Created by Николай Попов on 17.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct ButtonStyles_Previews: PreviewProvider {
    static var previews: some View {
        LazyVStack {
            Group {
                Button(action: {}) {
                    Text("Button 1")
                }
                .buttonStyle(PrimaryButton())
                Button(action: {}) {
                    Text("Button 1")
                }
                .buttonStyle(PrimaryButton(.medium))
                Button(action: {}) {
                    Text("Button 1")
                }
                .buttonStyle(PrimaryButton(.small))
            }
            Group {
                Button(action: {}) {
                    Text("Button 1")
                }
                .buttonStyle(SecondaryButton())
                Button(action: {}) {
                    Text("Button 1")
                }
                .buttonStyle(SecondaryButton(.medium))
                Button(action: {}) {
                    Text("Button 1")
                }
                .buttonStyle(SecondaryButton(.small))
            }
            Group {
                Button(action: {}) {
                    Text("Button 1")
                }
                .buttonStyle(TextButton())
                Button(action: {}) {
                    Text("Button 1")
                }
                .buttonStyle(TextButton(.medium))
                Button(action: {}) {
                    Text("Button 1")
                }
                .buttonStyle(TextButton(.small))
            }
            Group {
                Button(action: {}) {
                    Text("Button 1")
                }
                .buttonStyle(DisableButton())
                Button(action: {}) {
                    Text("Button 1")
                }
                .buttonStyle(DisableButton(.medium))
                Button(action: {}) {
                    Text("Button 1")
                }
                .buttonStyle(DisableButton(.small))
            }
        }
        .padding()
    }
}

enum ButtonSize {
    case large, small, medium
    
    var font: Font {
        switch self {
        case .large: return TypographyFontVariant.semibold(.six).font
        case .medium: return TypographyFontVariant.semibold(.seven).font
        case .small: return TypographyFontVariant.semibold(.eight).font
        }
    }
    
    var height: CGFloat {
        switch self {
        case .large: return 48
        case .medium: return 38
        case .small: return 32
        }
    }
    
    var width: CGFloat {
        switch self {
        case .large: return .infinity
        case .medium: return 160
        case .small: return 108
        }
    }

    
}



struct PrimaryButton: ButtonStyle {
    
    let size: ButtonSize
    let color: Color
    
    init(_ size: ButtonSize = .large, color: Color = Color.blue) {
        self.size = size
        self.color = color
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .font(size.font)
            .if(size == .large) { view in
                view.frame(maxWidth: .infinity)
            }
            .if(size != .large) { view in
                view.frame(width: size.width)
            }
            .frame(height: size.height)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

struct SecondaryButton: ButtonStyle {
    
    let size: ButtonSize
    let color: Color
    
    init(_ size: ButtonSize = .large, color: Color = Color.grayThree) {
        self.size = size
        self.color = color
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(color == Color.grayThree ? Color.accentBlue : color)
            .font(size.font)
            .if(size == .large) { view in
                view.frame(maxWidth: .infinity)
            }
            .if(size != .large) { view in
                view.frame(width: size.width)
            }
            .frame(height: size.height)
            .overlay {
                RoundedRectangle(cornerRadius: 6).stroke(color, lineWidth: 1)
            }
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}


struct TextButton: ButtonStyle {
    let size: ButtonSize
    
    init(_ size: ButtonSize = .large) {
        self.size = size
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.accentBlue)
            .font(size.font)
            .frame(height: size.height)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}


struct DisableButton: ButtonStyle {
    
    let size: ButtonSize
    
    init(_ size: ButtonSize = .large) {
        self.size = size
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.grayTwo)
            .font(size.font)
            .if(size == .large) { view in
                view.frame(maxWidth: .infinity)
            }
            .if(size != .large) { view in
                view.frame(width: size.width)
            }
            .frame(height: size.height)
            .background(Color.grayFour)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
