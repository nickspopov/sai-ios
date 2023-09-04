//
//  Typography.swift
//  iosApp
//
//  Created by Николай Попов on 21.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

enum TypographySizeVariant {
    case one, two, three, four, five, six, seven, eight
    
    var size: CGFloat {
        switch self {
        case .eight:
            return 12
        case .seven:
            return 14
        case .six:
            return 16
        case .five:
            return 18
        case .four:
            return 20
        case .three:
            return 24
        case .two:
            return 30
        case .one:
            return 38
        }
    }
        
    
}

enum TypographyFontVariant {
    case regular(TypographySizeVariant = .seven), bold(TypographySizeVariant = .seven), semibold(TypographySizeVariant = .seven)
    
    var font: Font {
        switch self {
        case let .regular(size):
            return .custom("Inter-Regular", size: size.size)
        case let .bold(size):
            return .custom("Inter-Bold", size: size.size)
        case let .semibold(size):
            return .custom("Inter-SemiBold", size: size.size)
        }
    }
}

struct Typography: View {
    
    let text: String
    let variant: TypographyFontVariant
    
    init(_ text: String, _ variant: TypographyFontVariant = .regular()) {
        self.text = text
        self.variant = variant
    }
    
    var body: some View {
        Text(text)
            .font(variant.font)
    }
}

struct Typography_Previews: PreviewProvider {
    static var previews: some View {
        let string = "ABCD123"
        
        HStack {
            VStack {
                Typography(string, .regular(.eight))
                Typography(string, .regular(.seven))
                Typography(string, .regular(.six))
                Typography(string, .regular(.five))
                Typography(string, .regular(.four))
                Typography(string, .regular(.three))
                Typography(string, .regular(.two))
                Typography(string, .regular(.one))
            }
            VStack {
                Typography(string, .bold(.eight))
                Typography(string, .bold(.seven))
                Typography(string, .bold(.six))
                Typography(string, .bold(.five))
                Typography(string, .bold(.four))
                Typography(string, .bold(.three))
                Typography(string, .bold(.two))
                Typography(string, .bold(.one))
            }
        }
    }
}
