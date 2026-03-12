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
                
                // App Logo + Title
                HStack(spacing: 8) {
                    
                    Image(systemName: "cross.case.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 24))
                    
                    Text("Clinic Flow")
                        .font(.system(size: 22, weight: .semibold))
                        .accessibilityAddTraits(.isHeader)
                }
                .padding(.top, 30)
                
                
                // Header Image
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.blue.opacity(0.4),
                                Color.blue.opacity(0.1)
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
                        .font(.system(size: 30, weight: .bold))
                    
                    Text("Sign in to manage your appointments and track live queues.")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                }
                
                
                // Email / Phone
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Email or Phone Number")
                        .font(.system(size: 14, weight: .medium))
                    
                    HStack {
                        
                        TextField("Enter your email or phone number", text: $emailOrPhone)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .accessibilityLabel("Email or phone number")
                        
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                
                
                // Password
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    HStack {
                        Text("Password")
                            .font(.system(size: 14, weight: .medium))
                        
                        Spacer()
                        
                        Button("Forgot Password?") {
                            
                        }
                        .font(.system(size: 14))
                        .foregroundColor(.blue)
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
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                
                
                // Login Button
                
                Button(action: onLoginSuccess) {
                    
                    Text("Log In")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.blue)
                        .cornerRadius(14)
                        .padding(.horizontal, 24)
                }
                .padding(.top, 10)
                
                
                // Sign Up
                
                HStack {
                    
                    Text("Don't have an account?")
                        .foregroundColor(.gray)
                    
                    Button("Sign Up") {
                        
                    }
                    .foregroundColor(.blue)
                }
                .font(.system(size: 15))
                
                Spacer()
            }
        }
        .background(Color(.systemBackground))
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    LoginView()
}
