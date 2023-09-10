//
//  SignInScreen.swift
//  sai
//
//  Created by Николай Попов on 04.09.2023.
//

import SwiftUI

struct SignInScreen: View {
    @EnvironmentObject var navigationController: NavigationController
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State var loading = false
    
    func onSignIn() {
        loading = true
        Task {
            let result = await AuthServiceFirebaseImpl.shared.signIn(email:email, password:password)
            
            switch result {
            case .success(_): navigationController.replace(to: [.homeScreen])
            case .failure(let error): print(error)
            }
            
            DispatchQueue.main.async {
                loading = false
            }
        }
    }
    
    
    var body: some View {
        Form {
            Section {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
            }
            
            Section {
                Button(action: onSignIn) {
                    if loading {
                        ProgressView()
                    } else {
                        Text("Sign In")
                    }
                }
            }
        }
    }
}

struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
    }
}
