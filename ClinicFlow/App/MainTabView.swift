//
//  MainTabView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import SwiftUI
import UIKit

struct MainTabView: View {
    
    @State private var selectedTab = 0

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.33, green: 0.16, blue: 0.96, alpha: 1.0)
        appearance.shadowColor = UIColor.black.withAlphaComponent(0.12)

        let selectedColor = UIColor.white
        let unselectedColor = UIColor.white.withAlphaComponent(0.55)

        appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: selectedColor]
        appearance.stackedLayoutAppearance.normal.iconColor = unselectedColor
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: unselectedColor]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().unselectedItemTintColor = unselectedColor
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                HomeView()
            }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            NavigationStack {
                MyVisitsView()
            }
                .tabItem {
                    Label("My Visits", systemImage: "calendar")
                }
                .tag(1)
            
            NavigationStack {
                RecordsView()
            }
                .tabItem {
                    Label("Records", systemImage: "doc.text.fill")
                }
                .tag(2)
            
            NavigationStack {
                NotificationsView()
            }
                .tabItem {
                    Label("Notifications", systemImage: "bell.fill")
                }
                .tag(3)
            
            NavigationStack {
                ProfileView()
            }
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(4)
        }
        .tint(.white)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
