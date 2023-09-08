//
//  FiltersRow.swift
//  sai
//
//  Created by Николай Попов on 06.09.2023.
//

import SwiftUI

struct FiltersRow: View {
    
    @Binding var activeIndex: Int
    @State var activeIndexAnimated: Int = 0
    
    @Namespace var namesapce
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                filterItem(name: "All", isActive: activeIndexAnimated == 0, onPress: {activeIndex = 0})
                filterItem(name: "Tasks", isActive: activeIndexAnimated == 1, onPress: {activeIndex = 1})
                filterItem(name: "Activity", isActive: activeIndexAnimated == 2, onPress: {activeIndex = 2})
                filterItem(name: "Meals", isActive: activeIndexAnimated == 3, onPress: {activeIndex = 3})
            }
            .padding(.leading, 16)
            .onChange(of: activeIndex) { newValue in
                withAnimation {
                    activeIndexAnimated = newValue
                }
            }
        }
    }
    
    func filterItem(name:String, isActive: Bool, onPress: @escaping () -> Void) -> some View {
        return Button(action: {onPress()}) {
            Typography(name, .medium(.five))
                .foregroundColor(isActive ? .black : .white)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(
            ZStack {
                if isActive {
                    Color.white
                        .cornerRadius(200)
                        .matchedGeometryEffect(id: "FiltersRow_bg_active_index", in: namesapce)
                }
            }
        )
        .overlay(content: {
            RoundedRectangle(cornerRadius: .infinity)
                .inset(by: 0.5)
                .stroke(Color(red: 0.82, green: 0.82, blue: 0.82), lineWidth: 1)
        })
        .buttonStyle(PlainButtonStyle())
    }
}

struct FiltersRow_Previews: PreviewProvider {
    static var previews: some View {
        FiltersRow(activeIndex: .constant(0))
            .preferredColorScheme(.dark)
    }
}
