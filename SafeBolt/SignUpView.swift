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
    var onSignUp: (String) -> Void
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private var isSignUpDisabled: Bool {
        return fullName.isEmpty
        || !isValidEmail(email)
        || phone.isEmpty
        || password.isEmpty
        || password != confirmPassword
        || !agreedToTerms
    }
    
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
                        onSignUp("Account Created!")
                    }
                    .disabled(isSignUpDisabled)
                    .opacity(isSignUpDisabled ? 0.5 : 1.0)
                    
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
//
//#Preview {
//    SignUpView(showSignIn: {})
//}
