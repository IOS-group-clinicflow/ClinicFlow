//
//  WelcomeView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-10.
//
import SwiftUI

struct WelcomeView: View {
    
    var onGetStarted: () -> Void = {}
    var onLogin: () -> Void = {}
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Spacer()
            
            // Doctor Image
            Image("doctor_welcome")
                .resizable()
                .scaledToFill()
                .frame(height: 340)
                .clipShape(RoundedRectangle(cornerRadius: AppSpacing.cornerRadiusLarge + 10))
                .padding(.horizontal, AppSpacing.screenHorizontal)
                .accessibilityLabel("Doctor consulting a patient")
            
            // Title
            VStack(spacing: 8) {
                
                Text("Your health,")
                    .font(AppTypography.largeTitle)
                    .foregroundColor(AppColors.textPrimary)
                
                Text("simplified.")
                    .font(AppTypography.largeTitle)
                    .foregroundColor(AppColors.primary)
                
            }
            .multilineTextAlignment(.center)
            .accessibilityAddTraits(.isHeader)
            
            
            // Description
            Text("Experience the future of healthcare. Book appointments instantly, track your live queue status, and access digital visit summaries.")
                .font(AppTypography.body)
                .foregroundColor(AppColors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppSpacing.xl - 2)
                .accessibilityLabel("Book appointments instantly, track your live queue, and access visit summaries.")
            
            
            // Page Indicator
            HStack(spacing: 6) {
                
                Capsule()
                    .fill(AppColors.primary)
                    .frame(width: 20, height: 6)
                
                Circle()
                    .fill(AppColors.textTertiary.opacity(0.4))
                    .frame(width: 6, height: 6)
                
                Circle()
                    .fill(AppColors.textTertiary.opacity(0.4))
                    .frame(width: 6, height: 6)
            }
            .padding(.top, 10)
            
            
            // Get Started Button
            
            PrimaryButton(title: "Get Started", icon: "arrow.right", action: onGetStarted)
                .accessibilityHint("Starts the onboarding process")
            .padding(.top, 10)
            
            
            // Login
            
            HStack {
                Text("Already have an account?")
                    .foregroundColor(AppColors.textSecondary)
                
                Button("Log in", action: onLogin)
                .foregroundColor(AppColors.primary)
            }
            .font(AppTypography.subheadline)
            .padding(.top, 5)
            
            Spacer()
        }
        .background(AppColors.background)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    WelcomeView()
}
