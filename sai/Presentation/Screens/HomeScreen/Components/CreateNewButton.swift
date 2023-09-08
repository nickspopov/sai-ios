//
//  CreateNewButton.swift
//  sai
//
//  Created by Николай Попов on 08.09.2023.
//

import SwiftUI

struct CreateNewButton: View {
    
    var title: String = "Create new"
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            HStack(alignment: .center, spacing: 8) {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.white)
                Typography(title, .medium(.six))
                    .frame(height: 24)
            }
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(.white.opacity(0.16))
            .cornerRadius(16)
        }
        .frame(maxWidth: .infinity)
        .buttonStyle(PlainButtonStyle())
    }
}

struct CreateNewButton_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewButton()
            .preferredColorScheme(.dark)
    }
}
