//
//  LoginView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-11.
//
import SwiftUI

struct LoginView: View {
    
    var onLoginSuccess: () -> Void = {}
    var onBack: () -> Void = {}
    
    @State private var emailOrPhone: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible = false
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 24) {
                
                HStack {
                    Button(action: onBack) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(AppColors.textPrimary)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, AppSpacing.screenHorizontal)
                .padding(.top, AppSpacing.sm)
                
                // App Logo + Title
                HStack(spacing: 8) {
                    
                    Image(systemName: "cross.case.fill")
                        .foregroundColor(AppColors.primary)
                        .font(.system(size: 24))
                    
                    Text("Clinic Flow")
                        .font(AppTypography.title)
                        .accessibilityAddTraits(.isHeader)
                }
                .padding(.top, 30)
                
                
                // Header Image
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                AppColors.primary.opacity(0.4),
                                AppColors.primary.opacity(0.1)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 180)
                    .overlay(
                        Image(systemName: "sparkles")
                            .font(.system(size: 40))
                            .foregroundColor(.white.opacity(0.8))
                    )
                    .padding(.horizontal, 24)
                
                
                // Welcome Text
                
                VStack(spacing: 6) {
                    
                    Text("Welcome back")
                        .font(AppTypography.largeTitle)
                    
                    Text("Sign in to manage your appointments and track live queues.")
                        .font(AppTypography.body)
                        .foregroundColor(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                }
                
                
                // Email / Phone
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Email or Phone Number")
                        .font(AppTypography.label)
                    
                    HStack {
                        
                        TextField("Enter your email or phone number", text: $emailOrPhone)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .accessibilityLabel("Email or phone number")
                        
                        Image(systemName: "envelope")
                            .foregroundColor(AppColors.textTertiary)
                    }
                    .padding()
                    .background(AppColors.cardBackground)
                    .cornerRadius(AppSpacing.cornerRadiusSmall + 2)
                }
                .padding(.horizontal, AppSpacing.screenHorizontal)
                
                
                // Password
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    HStack {
                        Text("Password")
                            .font(AppTypography.label)
                        
                        Spacer()
                        
                        Button("Forgot Password?") {
                            
                        }
                        .font(AppTypography.subheadline)
                        .foregroundColor(AppColors.primary)
                    }
                    
                    HStack {
                        
                        if isPasswordVisible {
                            TextField("Enter your password", text: $password)
                        } else {
                            SecureField("Enter your password", text: $password)
                        }
                        
                        Button {
                            isPasswordVisible.toggle()
                        } label: {
                            Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                .foregroundColor(AppColors.textTertiary)
                        }
                    }
                    .padding()
                    .background(AppColors.cardBackground)
                    .cornerRadius(AppSpacing.cornerRadiusSmall + 2)
                }
                .padding(.horizontal, AppSpacing.screenHorizontal)
                
                
                // Login Button
                
                PrimaryButton(title: "Log In", action: onLoginSuccess)
                .padding(.top, 10)
                
                
                // Sign Up
                
                HStack {
                    
                    Text("Don't have an account?")
                        .foregroundColor(AppColors.textSecondary)
                    
                    Button("Sign Up") {
                        
                    }
                    .foregroundColor(AppColors.primary)
                }
                .font(AppTypography.subheadline)
                
                Spacer()
            }
        }
        .background(AppColors.background)
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    LoginView()
}
