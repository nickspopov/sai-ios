//
//  FiltersRow.swift
//  sai
//
//  Created by Николай Попов on 06.09.2023.
//

import SwiftUI

struct FiltersRow: View {
    
    @Binding var activeIndex: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                filterItem(name: "All", isActive: activeIndex == 0, onPress: {activeIndex = 0})
                filterItem(name: "Tasks", isActive: activeIndex == 1, onPress: {activeIndex = 1})
                filterItem(name: "Activity", isActive: activeIndex == 2, onPress: {activeIndex = 2})
                filterItem(name: "Meals", isActive: activeIndex == 3, onPress: {activeIndex = 3})
            }
            .padding(.leading, 16)
        }
    }
    
    func filterItem(name:String, isActive: Bool, onPress: @escaping () -> Void) -> some View {
        return HStack(alignment: .center, spacing: 16) {
            Typography(name, .regular(.five))
                .foregroundColor(isActive ? .black : .white)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(isActive ? .white : Color(red: 0.15, green: 0.15, blue: 0.15))
        .cornerRadius(200)
        .onTapGesture {
            onPress()
        }
    }
}

struct FiltersRow_Previews: PreviewProvider {
    static var previews: some View {
        FiltersRow(activeIndex: .constant(0))
            .preferredColorScheme(.dark)
    }
}
