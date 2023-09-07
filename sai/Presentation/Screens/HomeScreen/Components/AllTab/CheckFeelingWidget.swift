//
//  CheckFeelingWidget.swift
//  sai
//
//  Created by Николай Попов on 07.09.2023.
//

import SwiftUI

struct CheckFeelingWidget: View {
    
    enum Field {
        case input
    }
    
    @State var text: String = ""
    @FocusState private var focusedField: Field?
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(spacing: 0) {
                Typography("How is", .medium(.six))
                Typography(" Sai ", .medium(.six))
                    .foregroundColor(.accentOrange)
                Typography("feeling today?", .medium(.six))
            }
            VStack {
                TextField("", text: $text, axis: .vertical)
                    .lineLimit(2...2)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .font(Font.custom("Inter-Regular", size: 14))
                    .background(
                        ZStack(alignment: .topLeading) {
                            Color(red: 0.22, green: 0.22, blue: 0.22)
                            if text.isEmpty {
                                Typography("Describe emotional/physical condition of your\ndog...", .regular(.seven))
                                    .foregroundColor(Color(red: 0.64, green: 0.62, blue: 0.62))
                                    .padding(.horizontal, 12)
                                    .padding(.top, 8)
                            }
                        }
                    )
                    .cornerRadius(12)
                    .focused($focusedField, equals: .input)
            }
            .onTapGesture {
                focusedField = .input
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
        .padding(.bottom, 16)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
        .cornerRadius(24)
    }
}

struct CheckFeelingWidget_Previews: PreviewProvider {
    static var previews: some View {
        CheckFeelingWidget()
            .preferredColorScheme(.dark)
    }
}


extension CheckFeelingWidget {
    var emotionsRow: some View {
        HStack {
            
        }
    }
}
