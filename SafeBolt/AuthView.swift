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
    
    var body: some View {
        ZStack {
            if currentScreen == .signIn {
                SignInView(showSignUp: {
                    withAnimation(.easeInOut) {
                        currentScreen = .signUp
                    }
                })
                .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
            } else {
                SignUpView(showSignIn: {
                    withAnimation(.easeInOut) {
                        currentScreen = .signIn
                    }
                })
                .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
            }
        }
    }
}
