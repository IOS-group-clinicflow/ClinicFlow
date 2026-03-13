//
//  ProfileView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-12.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: AppSpacing.sectionSpacing) {
                    SectionHeader(title: "My Profile")
                    PatientProfileCard(patient: MockData.currentUser)

                    VStack(spacing: 0) {
                        ProfileRow(label: "Full Name", value: MockData.currentUser.name, icon: "person")
                        Divider().padding(.horizontal, AppSpacing.screenHorizontal)
                        ProfileRow(label: "Age", value: "\(MockData.currentUser.age)", icon: "calendar")
                        Divider().padding(.horizontal, AppSpacing.screenHorizontal)
                        ProfileRow(label: "Relationship", value: MockData.currentUser.relationship, icon: "person.2")
                        Divider().padding(.horizontal, AppSpacing.screenHorizontal)
                        ProfileRow(label: "Emergency", value: MockData.currentUser.emergencyContact, icon: "phone")
                    }
                    .background(AppColors.cardBackground)
                    .cornerRadius(AppSpacing.cornerRadiusMedium)
                    .padding(.horizontal, AppSpacing.screenHorizontal)

                    SectionHeader(title: "Linked Profiles", actionTitle: "Add") {}
                    ForEach(MockData.linkedPatients) { patient in
                        PatientProfileCard(patient: patient) {}
                    }

                    SectionHeader(title: "Settings")

                    VStack(spacing: 0) {
                        SettingsRow(icon: "bell.fill", title: "Notifications", subtitle: "Queue and appointment alerts") {}
                        Divider().padding(.leading, 76)
                        SettingsRow(icon: "moon.fill", title: "Appearance", subtitle: "Light / Dark mode", iconColor: .purple) {}
                        Divider().padding(.leading, 76)
                        SettingsRow(icon: "textformat.size", title: "Text Size", subtitle: "Accessibility", iconColor: .orange) {}
                        Divider().padding(.leading, 76)
                        SettingsRow(icon: "globe", title: "Language", subtitle: "English", iconColor: .green) {}
                        Divider().padding(.leading, 76)
                        SettingsRow(icon: "lock.shield", title: "Privacy", subtitle: "Permissions and consent", iconColor: .indigo) {}
                    }
                    .background(AppColors.cardBackground)
                    .cornerRadius(AppSpacing.cornerRadiusMedium)
                    .padding(.horizontal, AppSpacing.screenHorizontal)

                    Text("Medical profile includes allergies, history, chronic conditions, and emergency contact details.")
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.textTertiary)
                        .padding(.horizontal, AppSpacing.screenHorizontal)
                }
                .padding(.top)
                .padding(.bottom, AppSpacing.lg)
            }
            .background(AppColors.background)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileView()
}
