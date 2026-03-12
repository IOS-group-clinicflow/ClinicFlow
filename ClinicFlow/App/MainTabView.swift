//
//  MainTabView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            MyVisitsView()
                .tabItem {
                    Label("My Visits", systemImage: "calendar")
                }
                .tag(1)
            
            RecordsView()
                .tabItem {
                    Label("Records", systemImage: "doc.text.fill")
                }
                .tag(2)
            
            NotificationsView()
                .tabItem {
                    Label("Notifications", systemImage: "bell.fill")
                }
                .tag(3)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(4)
        }
        .tint(AppColors.primary)
    }
}

#Preview {
    MainTabView()
}
