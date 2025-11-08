//
//  OnboardingView.swift
//  SafeBolt
//
//  Created by mac on 11/8/25.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentStep = 0
    @State private var showAuthView = false
    
    let steps = [
        OnboardingStep(icon: "shield.checkered", title: "Fast & Secure Banking", subtitle: "Experience seamless banking with top-notch security and lightning-fast transactions."),
        OnboardingStep(icon: "creditcard.fill", title: "Manage Your Finances", subtitle: "Track your spending, manage budgets, and achieve your financial goals with ease."),
        OnboardingStep(icon: "info.circle.fill", title: "24/7 Support", subtitle: "Our dedicated team is always here to help you with any questions or concerns.")
    ]
    
    var body: some View {
        ZStack {
            darkBlueBackground.ignoresSafeArea()
            
            if showAuthView {
                AuthView()
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            } else {
                VStack {
                    HStack {
                        Spacer()
                        if currentStep < steps.count - 1 {
                            Button("Skip") {
                                withAnimation {
                                    showAuthView = true
                                }
                            }
                            .foregroundColor(themeBrown)
                            .padding()
                        }
                    }
                    
                    TabView(selection: $currentStep) {
                        ForEach(steps.indices, id: \.self) { index in
                            OnboardingStepView(step: steps[index]).tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .animation(.easeInOut, value: currentStep)
                    
                    HStack(spacing: 8) {
                        ForEach(steps.indices, id: \.self) {index in
                            Capsule()
                                .fill(index == currentStep ? themeBrown : Color.gray.opacity(0.5))
                                .frame(width: index == currentStep ? 24 : 8, height: 8)
                                .animation(.spring(), value: currentStep)
                        }
                    }
                    .padding(.bottom, 30)
                    
                    VStack(spacing: 15) {
                        if currentStep == steps.count - 1 {
                            AppButton(title: "Get Started") {
                                withAnimation {
                                    showAuthView = true
                                }
                            }
                        } else {
                            AppButton(title: "Next") {
                                withAnimation {
                                    currentStep += 1
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer().frame(height: 40)
                }
                .foregroundColor(.white)
                .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
            }
        }
    }
    
    struct OnboardingStep {
        let icon: String
        let title: String
        let subtitle: String
    }
    
    struct OnboardingStepView: View {
        let step: OnboardingStep
        
        var body: some View {
            VStack(spacing: 20) {
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(themeBrown.opacity(0.3))
                        .frame(width: 120, height: 120)
                        .background(.ultraThinMaterial, in: Circle())
                    
                    Image(systemName: step.icon)
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.white.opacity(0.9))
                }
                .padding(.bottom, 20)
                
                Text(step.title)
                    .font(.system(size: 28, weight: .bold))
                
                Text(step.subtitle)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .foregroundColor(.white.opacity(0.7))
                
                Spacer()
                Spacer()
            }
        }
    }
}

#Preview {
    OnboardingView()
}
