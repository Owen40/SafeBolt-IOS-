//
//  SignUpView.swift
//  SafeBolt
//
//  Created by mac on 11/8/25.
//
import SwiftUI

struct SignUpView: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var agreedToTerms = false
    var showSignIn: () -> Void
    
    var body : some View {
        ZStack {
            darkBlueBackground.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Button(action: showSignIn) {
                        Image(systemName: "arrow.left")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 10)
                    
                    Text("Create Account")
                        .font(.system(size: 34, weight: .bold))
                    Text("Sign Up to get Started")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.7))
                    
                    Spacer().frame(height: 30)
                    
                    GlassTextField(title: "Full Name", text: $fullName)
                    GlassTextField(title: "Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    GlassTextField(title: "Phone Number", text: $phone)
                        .keyboardType(.phonePad)
                    GlassTextField(title: "Password", text: $password, isSecure: true)
                    GlassTextField(title: "Confirm Password", text: $confirmPassword, isSecure: true)
                    
                    Toggle(isOn: $agreedToTerms) {
                        Text("I agree to the terms of Service and Privacy Policy")
                            .font(.caption)
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    .foregroundColor(.white.opacity(0.8))
                    
                    Spacer().frame(height: 20)
                    
                    AppButton(title: "Create Account") {
                        // Create account action
                    }
                    .disabled(!agreedToTerms)
                    .opacity(agreedToTerms ? 1.0 : 0.6)
                    
                    HStack {
                        Spacer()
                        Text("Already have an account?")
                        Button("Sign In") {
                            showSignIn()
                        }
                        .foregroundColor(themeBrown)
                        .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.top)
                }
                .padding(25)
            }
        }
        .foregroundColor(.white)
    }
}

#Preview {
    SignUpView(showSignIn: {})
}
