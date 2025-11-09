//
//  ProfileView.swift
//  SafeBolt
//
//  Created by mac on 11/9/25.
//
import SwiftUI

struct ProfileView: View {
    @State private var isDarkMode = true
    var onLogout: () -> Void
    
    var body: some View {
        ZStack {
            darkBlueBackground.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    ProfileHeaderView(onLogout: onLogout)
                    
                    ProfileInfoView()
                    
                    VStack(spacing: 15) {
                        ProfileSectionView(title: "Account Status", subtitle: "Verified Premium Member", icon: "checkmark.circle.fill", iconColor: .green)
                        ProfileSectionView(title: "Personal Information", subtitle: "View and edit your profile", icon: "person.fill")
                        ProfileSectionView(title: "Security & Privacy", subtitle: "Manage your Security settings", icon: "lock.fill")
                        ProfileSectionView(title: "Cards & Accounts", subtitle: "Manage your linked accounts", icon: "creditcard.fill")
                        ProfileSectionView(title: "Notifications", subtitle: "Customize your alerts", icon: "bell.fill")
                        ProfileSectionView(title: "Limits & Preferences", subtitle: "Set transaction limits", icon: "dollarsign.circle.fill")
                        ProfileSectionView(title: "Help & Support", subtitle: "Get assistance", icon: "questionmark.circle.fill")
                        ProfileSectionView(title: "Terms & Policies", subtitle: "View legal documents", icon: "doc.text.fill")
                        
                        ProfileToggleView(title: "Dark Mode", subtitle: "Currently enabled", icon: "moon.fill", isOn: $isDarkMode)
                        
//                        Button(action: onLogout) {
//                            Text("Log out")
//                                .font(.headline.bold())
//                                .foregroundColor(.red)
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .background(.white.opacity(0.1))
//                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
//                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(.white.opacity(0.1), lineWidth: 1))
//                                .cornerRadius(12)
//                        }
//                        .padding(.top, 20)
                    }
                }
                .padding()
            }
            .foregroundColor(.white)
        }
    }
}

private struct ProfileHeaderView: View {
    var onLogout: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "arrow.left")
                .font(.title2.bold())
                .opacity(0)
            
            Spacer()
            
            Text("Profile")
                .font(.title2.bold())
            
            Spacer()
            
            Button(action: onLogout) {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.title2.bold())
                    .foregroundColor(themeBrown)
            }
        }
        .padding(.horizontal)
    }
}

private struct ProfileInfoView: View {
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(themeBrown.opacity(0.8))
                    .frame(width: 100, height: 100)
                Text("OM")
                    .font(.title.bold())
            }
            
            Text("Owen Muthami")
                .font(.title.bold())
            
            Text("owen@email.com")
                .font(.body)
                .foregroundColor(.white.opacity(0.7))
            
            Button(action: {}) {
                Text("Edit Profile")
                    .font(.headline.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)
                    .background(.white.opacity(0.1))
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white.opacity(0.2), lineWidth: 1))
            }
            .padding(.top, 10)
        }
    }
}

private struct ProfileSectionView: View {
    var title: String
    var subtitle: String
    var icon: String
    var iconColor: Color = .white
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(iconColor)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.5))
        }
        .padding()
        .background(.white.opacity(0.05))
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(.white.opacity(0.1), lineWidth: 1))
        .cornerRadius(16)
    }
}

private struct ProfileRowView: View {
    var title: String
    var subtitle: String
    var icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(themeBrown)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.5))
        }
        .padding(.vertical, 8)
    }
}

private struct ProfileToggleView: View {
    var title: String
    var subtitle: String
    var icon: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .tint(themeBrown)
        }
        .padding()
        .background(.white.opacity(0.05))
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(.white.opacity(0.1), lineWidth: 1))
        .cornerRadius(16)
    }
}

#Preview {
    ProfileView(onLogout: {})
}
