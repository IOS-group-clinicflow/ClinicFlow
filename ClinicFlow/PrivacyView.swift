//
//  PrivacyView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-11.
//
import SwiftUI

struct PrivacyView: View {
    
    @State private var gpsEnabled = true
    @State private var healthEnabled = false
    @State private var notificationsEnabled = true
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 22) {
                
                // MARK: Header
                
                HStack {
                    
                    Button(action: {
                        // back navigation
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Text("Privacy")
                        .font(.system(size: 20, weight: .semibold))
                    
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
                    .foregroundColor(.blue)
                    .padding(.horizontal)
                
                
                // MARK: Title
                
                Text("Your Privacy Matters")
                    .font(.system(size: 30, weight: .bold))
                    .padding(.horizontal)
                
                
                Text("To provide the best healthcare experience, Clinic Flow needs your permission to access the following features on your device.")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
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
                        .foregroundColor(.blue)
                    
                    Text("Your data is encrypted end-to-end and never shared with third parties without your explicit consent. You can change these settings at any time in the app settings.")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(14)
                .padding(.horizontal)
                
                
                // MARK: Agree Button
                
                Button(action: {
                    
                    print("User agreed to privacy settings")
                    
                }) {
                    
                    HStack {
                        
                        Text("Agree & Continue")
                            .font(.system(size: 18, weight: .semibold))
                        
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.blue)
                    .cornerRadius(14)
                    .padding(.horizontal)
                }
                .padding(.top)
                
                
                // MARK: Privacy Policy
                
                HStack {
                    Spacer()
                    
                    Button("Learn more about our Privacy Policy") {
                        print("Privacy policy tapped")
                    }
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    
                    Spacer()
                }
                
                Spacer(minLength: 30)
            }
            .padding(.top)
        }
        .background(Color(.systemBackground))
    }
}

#Preview {
    PrivacyView()
}
