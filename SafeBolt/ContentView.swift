//
//  ContentView.swift
//  SafeBolt
//
//  Created by mac on 11/8/25.
//

import SwiftUI

enum AppState {
    case loading, onboarding, auth, main
}

struct ContentView: View {
    @State private var appState: AppState = .loading
    
    @State private var showToast = false
    @State private var toastMessage = ""
    
    var body: some View {
        ZStack {
            switch appState {
            case .loading:
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                appState = .onboarding
                            }
                        }
                    }
            case .onboarding:
                OnboardingView(onComplete: {
                    withAnimation {
                        appState = .auth
                    }
                })
            case .auth:
                AuthView(onAuthenticated: { message in
                    toastMessage = message
                    showToast = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation {
                            appState = .main
                        }
                    }
                })
            case .main:
                MainTabView(onLogout: {
                    withAnimation {
                        appState = .auth
                    }
                })
            }
        }
        .preferredColorScheme(.dark)
        .overlay(
            ToastView(message: toastMessage, isShowing: $showToast)
        )
    }
}

#Preview {
    ContentView()
}
