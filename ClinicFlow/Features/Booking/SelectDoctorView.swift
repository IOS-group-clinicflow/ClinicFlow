//
//  SelectDoctorView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct SelectDoctorView: View {
    @Binding var state: BookingFlowState
    let onBack: () -> Void
    let onNext: () -> Void

    @State private var searchText = ""

    private var filteredDoctors: [Doctor] {
        var doctors = MockData.doctors

        if let selectedSpecialty = state.selectedSpecialty {
            let scoped = doctors.filter {
                $0.specialty.localizedCaseInsensitiveContains(selectedSpecialty)
                    || selectedSpecialty.localizedCaseInsensitiveContains($0.specialty)
            }
            if !scoped.isEmpty {
                doctors = scoped
            }
        }

        if !searchText.isEmpty {
            doctors = doctors.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
                    || $0.specialty.localizedCaseInsensitiveContains(searchText)
            }
        }

        return doctors
    }

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.sectionSpacing) {
                if let selectedSpecialty = state.selectedSpecialty {
                    HStack {
                        Text("Specialty")
                            .font(AppTypography.subheadline)
                            .foregroundColor(AppColors.textSecondary)
                        Spacer()
                        TagView(text: selectedSpecialty)
                    }
                    .padding(.horizontal, AppSpacing.screenHorizontal)
                }

                SearchBarView(text: $searchText, placeholder: "Search doctor")

                ForEach(filteredDoctors) { doctor in
                    VStack(spacing: AppSpacing.xs) {
                        DoctorCard(doctor: doctor, onTap: {
                            if state.selectedDoctor?.id != doctor.id {
                                state.selectedDate = nil
                                state.selectedTime = nil
                                state.selectedPaymentMethod = nil
                            }
                            state.selectedDoctor = doctor
                        })
                        .accessibilityHint("Select \(doctor.name) for this appointment")

                        if state.selectedDoctor?.id == doctor.id {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(AppColors.success)
                                Text("Selected")
                                    .font(AppTypography.caption)
                                    .foregroundColor(AppColors.success)
                                Spacer()
                            }
                            .padding(.horizontal, AppSpacing.screenHorizontal)
                        }
                    }
                }

                HStack(spacing: AppSpacing.md) {
                    SecondaryButton(title: "Back", action: onBack)
                    PrimaryButton(title: "Continue", icon: "arrow.right", action: onNext)
                        .disabled(state.selectedDoctor == nil)
                        .opacity(state.selectedDoctor == nil ? 0.5 : 1)
                }
            }
            .padding(.top)
            .padding(.bottom, AppSpacing.lg)
        }
        .background(AppColors.background)
    }
}

#Preview {
    SelectDoctorView(state: .constant(BookingFlowState()), onBack: {}) {}
}
