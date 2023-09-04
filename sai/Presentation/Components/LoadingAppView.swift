//
//  LoadingAppView.swift
//  sai
//
//  Created by Николай Попов on 04.09.2023.
//

import SwiftUI

struct LoadingAppView: View {
    var body: some View {
        VStack {
            ProgressView().progressViewStyle(CircularProgressViewStyle())
        }
    }
}

struct LoadingAppView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAppView()
            .preferredColorScheme(.dark)
    }
}
