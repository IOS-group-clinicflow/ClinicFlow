//
//  RootView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import SwiftUI

struct RootView: View {
    
    @State private var currentScreen: AppScreen = .welcome
    
    var body: some View {
        NavigationStack {
            switch currentScreen {
            case .welcome:
                WelcomeView(onGetStarted: {
                    currentScreen = .login
                }, onLogin: {
                    currentScreen = .login
                })
                .navigationBarBackButtonHidden(true)
                
            case .login:
                LoginView(onLoginSuccess: {
                    currentScreen = .privacy
                }, onBack: {
                    currentScreen = .welcome
                })
                .navigationBarBackButtonHidden(true)
                
            case .privacy:
                PrivacyView(onAgree: {
                    currentScreen = .mainApp
                }, onBack: {
                    currentScreen = .login
                })
                .navigationBarBackButtonHidden(true)
                
            case .mainApp:
                MainTabView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

enum AppScreen {
    case welcome
    case login
    case privacy
    case mainApp
}

#Preview {
    RootView()
}
