//
//  SelectPatientView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct SelectPatientView: View {
    @Binding var state: BookingFlowState
    let onNext: () -> Void

    @FocusState private var focusedField: Field?
    @State private var didPrefillCurrentUser = false

    private enum Field {
        case name
        case age
        case emergencyContact
    }

    private var patients: [Patient] {
        MockData.allPatients
    }

    private let relationshipOptions = ["Self", "Child", "Parent", "Spouse", "Sibling", "Other"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.sectionSpacing) {
                Text("Enter patient details first, then continue to choose the specialist, doctor, date, time, and payment details.")
                    .font(AppTypography.body)
                    .foregroundColor(AppColors.textSecondary)
                    .padding(.horizontal, AppSpacing.screenHorizontal)

                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    SectionHeader(title: "Saved Profiles")

                    ForEach(patients) { patient in
                        VStack(spacing: AppSpacing.sm) {
                            PatientProfileCard(patient: patient, onTap: {
                                state.loadPatientDraft(from: patient)
                            })

                            if isDraftLoaded(for: patient) {
                                HStack {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(AppColors.success)
                                    Text("Profile loaded into the booking form")
                                        .font(AppTypography.caption)
                                        .foregroundColor(AppColors.success)
                                    Spacer()
                                }
                                .padding(.horizontal, AppSpacing.screenHorizontal)
                            }
                        }
                    }
                }
                .padding(.top, AppSpacing.xs)

                SectionHeader(title: "Patient Form")
                patientInputCard
                healthProfileCard

                if !state.isPatientDetailsComplete {
                    Text("Add the patient's full name, relationship, age, and contact number to continue.")
                        .font(AppTypography.caption)
                        .foregroundColor(AppColors.warning)
                        .padding(.horizontal, AppSpacing.screenHorizontal)
                }

                PrimaryButton(title: "Continue to Specialist", icon: "arrow.right") {
                    state.finalizePatientDetails()
                    onNext()
                }
                .disabled(!state.isPatientDetailsComplete)
                .opacity(state.isPatientDetailsComplete ? 1 : 0.5)
                .padding(.top, AppSpacing.sm)
            }
            .padding(.top)
            .padding(.bottom, AppSpacing.lg)
        }
        .background(AppColors.background)
        .onAppear {
            prefillCurrentUserIfNeeded()
        }
    }

    private var patientInputCard: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            BookingInputField(
                title: "Full Name",
                text: $state.patientFullName,
                prompt: "Enter the patient's full name"
            )
            .textInputAutocapitalization(.words)
            .focused($focusedField, equals: .name)
            .submitLabel(.next)
            .onSubmit {
                focusedField = .age
            }

            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text("Relationship")
                    .font(AppTypography.label)
                    .foregroundColor(AppColors.textPrimary)

                Picker("Relationship", selection: $state.patientRelationship) {
                    ForEach(relationshipOptions, id: \.self) { relationship in
                        Text(relationship).tag(relationship)
                    }
                }
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, AppSpacing.cardPadding)
                .padding(.vertical, 14)
                .background(AppColors.cardBackground)
                .cornerRadius(AppSpacing.cornerRadiusMedium)
                .accessibilityHint("Select how the patient is related to the account owner")
            }

            BookingInputField(
                title: "Age",
                text: $state.patientAge,
                prompt: "Enter age"
            )
            .keyboardType(.numberPad)
            .focused($focusedField, equals: .age)
            .submitLabel(.next)
            .onSubmit {
                focusedField = .emergencyContact
            }

            BookingInputField(
                title: "Contact Number",
                text: $state.patientEmergencyContact,
                prompt: "Enter a reachable contact number"
            )
            .keyboardType(.phonePad)
            .textContentType(.telephoneNumber)
            .focused($focusedField, equals: .emergencyContact)
        }
        .padding(AppSpacing.cardPadding)
        .background(AppColors.secondaryBackground)
        .cornerRadius(AppSpacing.cornerRadiusLarge)
        .padding(.horizontal, AppSpacing.screenHorizontal)
    }

    private var healthProfileCard: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            Text("Health Profile")
                .font(AppTypography.headline)
                .foregroundColor(AppColors.textPrimary)

            BookingMultilineField(
                title: "Allergies",
                text: $state.patientAllergies,
                prompt: "Example: Penicillin, peanuts"
            )

            BookingMultilineField(
                title: "Medical History",
                text: $state.patientMedicalHistory,
                prompt: "Example: Appendectomy in 2021"
            )

            BookingMultilineField(
                title: "Chronic Conditions",
                text: $state.patientChronicConditions,
                prompt: "Example: Asthma, hypertension"
            )

            BookingMultilineField(
                title: "Health Notes",
                text: $state.patientHealthNotes,
                prompt: "Add any notes the doctor should know before the visit"
            )

            Text("Separate multiple items with commas so the information stays easy to review in the prototype.")
                .font(AppTypography.caption)
                .foregroundColor(AppColors.textSecondary)
        }
        .padding(AppSpacing.cardPadding)
        .background(AppColors.secondaryBackground)
        .cornerRadius(AppSpacing.cornerRadiusLarge)
        .padding(.horizontal, AppSpacing.screenHorizontal)
    }

    private func isDraftLoaded(for patient: Patient) -> Bool {
        state.patientFullName == patient.name
            && state.patientRelationship == patient.relationship
            && state.patientAge == String(patient.age)
    }

    private func prefillCurrentUserIfNeeded() {
        guard !didPrefillCurrentUser else { return }
        guard state.patientFullName.isEmpty, state.patientAge.isEmpty, state.patientEmergencyContact.isEmpty else {
            didPrefillCurrentUser = true
            return
        }

        state.loadPatientDraft(from: MockData.currentUser)
        didPrefillCurrentUser = true
    }
}

private struct BookingInputField: View {
    let title: String
    @Binding var text: String
    let prompt: String

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            Text(title)
                .font(AppTypography.label)
                .foregroundColor(AppColors.textPrimary)

            TextField(prompt, text: $text)
                .font(AppTypography.body)
                .padding(.horizontal, AppSpacing.cardPadding)
                .frame(height: 52)
                .background(AppColors.cardBackground)
                .cornerRadius(AppSpacing.cornerRadiusMedium)
                .accessibilityLabel(title)
        }
    }
}

private struct BookingMultilineField: View {
    let title: String
    @Binding var text: String
    let prompt: String

    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            Text(title)
                .font(AppTypography.label)
                .foregroundColor(AppColors.textPrimary)

            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: AppSpacing.cornerRadiusMedium)
                    .fill(AppColors.cardBackground)

                if text.isEmpty {
                    Text(prompt)
                        .font(AppTypography.subheadline)
                        .foregroundColor(AppColors.textTertiary)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                }

                TextEditor(text: $text)
                    .font(AppTypography.body)
                    .scrollContentBackground(.hidden)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .frame(minHeight: 92)
                    .accessibilityLabel(title)
            }
            .frame(minHeight: 92)
        }
    }
}

#Preview {
    SelectPatientView(state: .constant(BookingFlowState())) {}
}
