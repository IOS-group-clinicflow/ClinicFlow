//
//  ProfileView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-12.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var appearanceStore: AppAppearanceStore
    @State private var showingAddPatient = false

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

                    SectionHeader(title: "Linked Profiles", actionTitle: "Add") {
                        showingAddPatient = true
                    }
                    ForEach(MockData.linkedPatients) { patient in
                        NavigationLink {
                            LinkedProfilesView()
                        } label: {
                            PatientProfileCard(patient: patient) {}
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
                        SettingsRow(icon: "bell.fill", title: "Notifications", subtitle: "Queue and appointment alerts")
                        Divider().padding(.leading, 76)
                        NavigationLink {
                            AppearanceSettingsView()
                        } label: {
                            SettingsRow(
                                icon: appearanceStore.appearance == .dark ? "moon.fill" : "sun.max.fill",
                                title: "Appearance",
                                subtitle: appearanceStore.appearance.title,
                                iconColor: appearanceStore.appearance == .dark ? .indigo : .orange
                            )
                        }
                        .buttonStyle(.plain)
                        Divider().padding(.leading, 76)
                        SettingsRow(icon: "textformat.size", title: "Text Size", subtitle: "Accessibility", iconColor: .orange)
                        Divider().padding(.leading, 76)
                        SettingsRow(icon: "globe", title: "Language", subtitle: "English", iconColor: .green)
                        Divider().padding(.leading, 76)
                        SettingsRow(icon: "lock.shield", title: "Privacy", subtitle: "Permissions and consent", iconColor: .indigo)
                    }
                    .background(AppColors.cardBackground)
                    .cornerRadius(AppSpacing.cornerRadiusMedium)
                    .padding(.horizontal, AppSpacing.screenHorizontal)

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
            .sheet(isPresented: $showingAddPatient) {
                NavigationStack {
                    AddNewPatientView()
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppAppearanceStore())
}
