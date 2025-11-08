//
//  HelperView.swift
//  SafeBolt
//
//  Created by mac on 11/8/25.
//
import SwiftUI

struct AppButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline.bold())
                .foregroundColor(.black.opacity(0.8))
                .frame(maxWidth: .infinity)
                .padding()
                .background(themeBrown)
                .cornerRadius(12)
                .shadow( color: themeBrown.opacity(0.4), radius: 8, y: 5)
        }
    }
}

struct GlassTextField: View {
    var title: String
    @Binding var text: String
    var isSecure: Bool = false
    
    // Custom placeholder text
    private var placeholder: String {
        "Enter your \(title.lowercased())"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
            
            ZStack(alignment: .leading) {
                // The main field
                if isSecure {
                    TextField("", text: $text)
                        .fieldStyle()
                } else {
                    TextField("", text: $text)
                        .fieldStyle()
                }
                
                // Custom placeholder
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.white.opacity(0.3))
                        .padding(.horizontal, 16)
                        .allowsHitTesting(false)
                }
            }
            .background(.white.opacity(0.05)) // Glass base color
            .background(.ultraThinMaterial) // The "Liquid Glass" effect
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.white.opacity(0.2), lineWidth: 1) // Subtle border
            )
            .cornerRadius(12)
        }
    }
}

struct GlassFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(16)
            .foregroundColor(.white)
            .tint(themeBrown)
    }
}

extension View {
    func fieldStyle() -> some View {
        self.modifier(GlassFieldStyle())
    }
}

struct SocialLoginButton: View {
    var icon: String
    var text: String
    
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.title3)
                Text(text)
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.white.opacity(0.05)) // Glass base
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12)) // Glass effect
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.white.opacity(0.1), lineWidth: 1)
            )
            .cornerRadius(12)
            .foregroundColor(.white)
        }
    }
}

// Custom Checkbox Style
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .font(.body)
                    .foregroundColor(configuration.isOn ? themeBrown : .gray)
                configuration.label
            }
        }
        .buttonStyle(.plain)
    }
}
