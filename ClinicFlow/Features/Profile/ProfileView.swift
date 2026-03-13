//
//  ProfileView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-12.
//

import SwiftUI

struct ProfileView: View {
    @State private var showingAddPatient = false

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.sectionSpacing) {
                SectionHeader(title: "My Profile")

                NavigationLink {
                    PatientDetailsView(patient: MockData.currentUser)
                } label: {
                    PatientProfileCard(patient: MockData.currentUser, onTap: nil)
                }
                .buttonStyle(.plain)

                NavigationLink {
                    PatientDetailsView(patient: MockData.currentUser)
                } label: {
                    SettingsRow(
                        icon: "person.text.rectangle",
                        title: "Personal Details",
                        subtitle: "Open full medical and contact profile",
                        iconColor: AppColors.primary
                    )
                }
                .buttonStyle(.plain)
                .background(AppColors.cardBackground)
                .cornerRadius(AppSpacing.cornerRadiusMedium)
                .padding(.horizontal, AppSpacing.screenHorizontal)

                SectionHeader(title: "Linked Profiles", actionTitle: "Add") {
                    showingAddPatient = true
                }
                ForEach(MockData.linkedPatients) { patient in
                    NavigationLink {
                        PatientDetailsView(patient: patient)
                    } label: {
                        PatientProfileCard(patient: patient, onTap: nil)
                    }
                    .buttonStyle(.plain)
                }

                NavigationLink {
                    LinkedProfilesView()
                } label: {
                    SettingsRow(icon: "person.2", title: "Manage Linked Profiles", subtitle: "View and update dependents", iconColor: AppColors.info)
                }
                .buttonStyle(.plain)
                .background(AppColors.cardBackground)
                .cornerRadius(AppSpacing.cornerRadiusMedium)
                .padding(.horizontal, AppSpacing.screenHorizontal)

                SectionHeader(title: "Settings")

                VStack(spacing: 0) {
                    NavigationLink {
                        AppSettingsView()
                    } label: {
                        SettingsRow(icon: "gearshape", title: "App Settings", subtitle: "Notifications, appearance, text size", iconColor: AppColors.primary)
                    }
                    .buttonStyle(.plain)

                    Divider().padding(.leading, 76)

                    NavigationLink {
                        PaymentsView()
                    } label: {
                        SettingsRow(icon: "creditcard", title: "Payments", subtitle: "Paid, pending, and required", iconColor: AppColors.info)
                    }
                    .buttonStyle(.plain)

                    Divider().padding(.leading, 76)

                    Button {
                        showingAddPatient = true
                    } label: {
                        SettingsRow(icon: "person.badge.plus", title: "Add New Patient", subtitle: "Add dependent profile", iconColor: AppColors.success)
                    }
                    .buttonStyle(.plain)
                }
                .background(AppColors.cardBackground)
                .cornerRadius(AppSpacing.cornerRadiusMedium)
                .padding(.horizontal, AppSpacing.screenHorizontal)

                Text("Medical profile includes allergies, history, chronic conditions, health notes, and emergency contact details.")
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
        .sheet(isPresented: $showingAddPatient) {
            NavigationStack {
                AddNewPatientView()
            }
        }
    }
}

#Preview {
    ProfileView()
}
