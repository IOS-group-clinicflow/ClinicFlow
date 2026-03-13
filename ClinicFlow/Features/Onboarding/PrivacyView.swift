//
//  PrivacyView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-11.
//
import SwiftUI

struct PrivacyView: View {
    
    var onAgree: () -> Void = {}
    var onBack: () -> Void = {}
    
    @State private var gpsEnabled = true
    @State private var healthEnabled = false
    @State private var notificationsEnabled = true
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 22) {
                
                // MARK: Header
                
                HStack {
                    
                    Button(action: onBack) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(AppColors.textPrimary)
                    }
                    
                    Spacer()
                    
                    Text("Privacy")
                        .font(AppTypography.title)
                    
                    Spacer()
                    
                    // spacing alignment
                    Rectangle()
                        .frame(width: 20)
                        .opacity(0)
                }
                .padding(.horizontal)
                
                
                // MARK: Icon
                
                Image(systemName: "shield.checkmark")
                    .font(.system(size: 45))
                    .foregroundColor(AppColors.primary)
                    .padding(.horizontal)
                
                
                // MARK: Title
                
                Text("Your Privacy Matters")
                    .font(AppTypography.largeTitle)
                    .padding(.horizontal)
                
                
                Text("To provide the best healthcare experience, Clinic Flow needs your permission to access the following features on your device.")
                    .font(AppTypography.body)
                    .foregroundColor(AppColors.textSecondary)
                    .padding(.horizontal)
                
                
                // MARK: Permission Cards
                
                PermissionCard(
                    icon: "location",
                    title: "GPS Usage",
                    description: "Used to automatically check you in when you arrive at the clinic.",
                    isOn: $gpsEnabled
                )
                
                PermissionCard(
                    icon: "heart",
                    title: "Health Data",
                    description: "Syncs with Apple HealthKit to share vital stats with your provider.",
                    isOn: $healthEnabled
                )
                
                PermissionCard(
                    icon: "bell",
                    title: "Push Notifications",
                    description: "Get real-time alerts about your position in the live queue.",
                    isOn: $notificationsEnabled
                )
                
                
                // MARK: Info Card
                
                HStack(alignment: .top, spacing: 12) {
                    
                    Image(systemName: "lock.fill")
                        .foregroundColor(AppColors.primary)
                    
                    Text("Your data is encrypted end-to-end and never shared with third parties without your explicit consent. You can change these settings at any time in the app settings.")
                        .font(AppTypography.subheadline)
                        .foregroundColor(AppColors.textSecondary)
                }
                .padding()
                .background(AppColors.cardBackground)
                .cornerRadius(AppSpacing.cornerRadiusMedium)
                .padding(.horizontal)
                
                
                // MARK: Agree Button
                
                PrimaryButton(title: "Agree & Continue", icon: "arrow.right", action: onAgree)
                .padding(.top)
                
                
                // MARK: Privacy Policy
                
                HStack {
                    Spacer()
                    
                    Button("Learn more about our Privacy Policy") {
                        print("Privacy policy tapped")
                    }
                    .font(AppTypography.subheadline)
                    .foregroundColor(AppColors.textSecondary)
                    
                    Spacer()
                }
                
                Spacer(minLength: 30)
            }
            .padding(.top)
        }
        .background(AppColors.background)
    }
}

#Preview {
    PrivacyView()
}
