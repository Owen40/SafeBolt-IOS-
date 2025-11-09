//
//  MainTabView.swift
//  SafeBolt
//
//  Created by mac on 11/9/25.
//
import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    var onLogout: () -> Void
    
    init(onLogout: @escaping () -> Void) {
        self.onLogout = onLogout
        
        let appearance = UITabBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(darkBlueBackground)
        
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 10)
        ]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            WalletView()
                .tabItem {
                    Image(systemName: "wallet.pass.fill")
                    Text("Wallet")
                }
                .tag(1)
            
            NotificationsView()
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("Notifications")
                }
                .tag(2)
            ProfileView(onLogout: onLogout)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Account")
                }
                .tag(3)
        }
        .tint(themeBrown)
    }
}

#Preview {
    MainTabView(onLogout: {} )
}
