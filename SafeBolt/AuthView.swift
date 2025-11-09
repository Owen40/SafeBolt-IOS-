//
//  AuthView.swift
//  SafeBolt
//
//  Created by mac on 11/8/25.
//
import SwiftUI

enum AuthScreen {
    case signIn, signUp
}

struct AuthView: View {
    @State private var currentScreen: AuthScreen = .signIn
    var onAuthenticated: (String) -> Void
    
    var body: some View {
        ZStack {
            if currentScreen == .signIn {
                SignInView(
                showSignUp: {
                    withAnimation(.easeInOut) {
                        currentScreen = .signUp
                    }
                },
                onSignIn: { message in
                    onAuthenticated(message)
                }
                )
                .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
            } else {
                SignUpView(
                    showSignIn: {
                    withAnimation(.easeInOut) {
                        currentScreen = .signIn
                    }
                },
                    onSignUp: {  message in
                        onAuthenticated(message)
                    }
                )
                .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
            }
        }
    }
}
