//
//  AddNewPatientView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct AddNewPatientView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var fullName = ""
    @State private var relationship = ""
    @State private var age = ""
    @State private var emergencyContact = ""
    @State private var allergies = ""
    @State private var chronicConditions = ""
    @State private var showSavedAlert = false

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.sectionSpacing) {
                formField(title: "Full Name", text: $fullName)
                formField(title: "Relationship", text: $relationship)
                formField(title: "Age", text: $age, keyboardType: .numberPad)
                formField(title: "Emergency Contact", text: $emergencyContact, keyboardType: .phonePad)
                formField(title: "Allergies (optional)", text: $allergies)
                formField(title: "Chronic Conditions (optional)", text: $chronicConditions)

                PrimaryButton(title: "Save Patient", icon: "checkmark") {
                    showSavedAlert = true
                }
                .disabled(!isFormValid)
                .opacity(isFormValid ? 1 : 0.5)
            }
            .padding(.top)
            .padding(.bottom, AppSpacing.lg)
        }
        .background(AppColors.background)
        .navigationTitle("Add New Patient")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Patient Added", isPresented: $showSavedAlert) {
            Button("Done") { dismiss() }
        } message: {
            Text("\(fullName) has been added to linked profiles.")
        }
    }

    private var isFormValid: Bool {
        !fullName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && !relationship.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && !age.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && !emergencyContact.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private func formField(title: String, text: Binding<String>, keyboardType: UIKeyboardType = .default) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            Text(title)
                .font(AppTypography.label)
                .foregroundColor(AppColors.textSecondary)

            TextField("Enter \(title.lowercased())", text: text)
                .keyboardType(keyboardType)
                .padding(AppSpacing.md)
                .background(AppColors.cardBackground)
                .cornerRadius(AppSpacing.cornerRadiusSmall)
        }
        .padding(.horizontal, AppSpacing.screenHorizontal)
    }
}

#Preview {
    NavigationStack {
        AddNewPatientView()
    }
}
