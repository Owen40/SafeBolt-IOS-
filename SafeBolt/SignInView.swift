//
//  SignInView.swift
//  SafeBolt
//
//  Created by mac on 11/8/25.
//
import SwiftUI

struct SignInView : View {
    @State private var email = ""
    @State private var password = ""
    var showSignUp: () -> Void
    var onSignIn: (String) -> Void
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private var isSignInDisabled: Bool {
        return !isValidEmail(email) || password.isEmpty
    }
    
    var body: some View {
        ZStack {
            darkBlueBackground.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Welcome Back")
                        .font(.system(size: 34, weight: .bold))
                    Text("Sign in to continue")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.7))
                    
                    Spacer().frame(height: 30)
                    
                    GlassTextField(title: "Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    GlassTextField(title: "Password", text: $password, isSecure: true)
                    
                    HStack {
                        Spacer()
                        Button("Forgot Password") {
                            //Action
                        }
                        .font(.subheadline.bold())
                        .foregroundColor(themeBrown)
                    }
                    
                    Spacer().frame(height: 20)
                    
                    AppButton(title: "Sign In") {
                        // Action
                        onSignIn("Signed In Successfully!")
                    }
                    .disabled(isSignInDisabled)
                    .opacity(isSignInDisabled ? 0.6 : 1.0)
                    
                    HStack {
                        Spacer()
                        Text("Don't have an account?")
                            .foregroundColor(.white.opacity(0.7))
                        Button("Sign Up") {
                            showSignUp()
                        }
                        .foregroundColor(themeBrown)
                        .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.top)
                    
                    HStack(spacing: 15) {
                        VStack { Divider().background(.white.opacity(0.3)) }
                        Text("Or Continue With")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                        VStack { Divider().background(.white.opacity(0.3)) }
                    }
                    .padding(.vertical, 30)
                    
                    HStack(spacing: 20) {
                        SocialLoginButton(icon: "g.circle.fill", text: "Google")
                        SocialLoginButton(icon: "applelogo", text: "Apple")
                    }
                }
                .padding(25)
            }
        }
        .foregroundColor(.white)
    }
}

