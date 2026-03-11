//
//  WelcomeView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-10.
//
import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Spacer()
            
            // Doctor Image
            Image("doctor_welcome")
                .resizable()
                .scaledToFill()
                .frame(height: 340)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .padding(.horizontal, 24)
                .accessibilityLabel("Doctor consulting a patient")
            
            // Title
            VStack(spacing: 8) {
                
                Text("Your health,")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.primary)
                
                Text("simplified.")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(Color.blue)
                
            }
            .multilineTextAlignment(.center)
            .accessibilityAddTraits(.isHeader)
            
            
            // Description
            Text("Experience the future of healthcare. Book appointments instantly, track your live queue status, and access digital visit summaries.")
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .accessibilityLabel("Book appointments instantly, track your live queue, and access visit summaries.")
            
            
            // Page Indicator
            HStack(spacing: 6) {
                
                Capsule()
                    .fill(Color.blue)
                    .frame(width: 20, height: 6)
                
                Circle()
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 6, height: 6)
                
                Circle()
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 6, height: 6)
            }
            .padding(.top, 10)
            
            
            // Get Started Button
            
            Button(action: {
                print("Get Started tapped")
            }) {
                
                HStack {
                    Text("Get Started")
                        .font(.system(size: 18, weight: .semibold))
                    
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.blue)
                .cornerRadius(14)
                .padding(.horizontal, 24)
                .accessibilityHint("Starts the onboarding process")
            }
            .padding(.top, 10)
            
            
            // Login
            
            HStack {
                Text("Already have an account?")
                    .foregroundColor(.gray)
                
                Button("Log in") {
                    print("Login tapped")
                }
                .foregroundColor(.blue)
            }
            .font(.system(size: 15))
            .padding(.top, 5)
            
            Spacer()
        }
        .background(Color(.systemBackground))
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    WelcomeView()
}
