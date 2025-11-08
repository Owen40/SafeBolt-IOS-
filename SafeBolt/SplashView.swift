//
//  SplashView.swift
//  SafeBolt
//
//  Created by mac on 11/8/25.
//
import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            darkBlueBackground.ignoresSafeArea()
            
            VStack(spacing: 20) {
                ZStack {
                    Circle()
                        .fill(.linearGradient(colors: [themeBrown.opacity(0.4), themeBrown.opacity(0.1)], startPoint: .top, endPoint: .bottom))
                        .frame(width: 140, height: 140)
                        .background(.ultraThinMaterial, in: Circle())
                        .overlay(Circle().stroke(.white.opacity(0.2), lineWidth: 1))
                    
                    Image(systemName: "bolt.shield.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.2), radius: 5, y: 5)
                }
                
                Text("Safe Bolt")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    SplashView()
}
