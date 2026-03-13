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

    private var patients: [Patient] {
        MockData.allPatients
    }

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.sectionSpacing) {
                Text("Choose who this appointment is for.")
                    .font(AppTypography.body)
                    .foregroundColor(AppColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, AppSpacing.screenHorizontal)

                ForEach(patients) { patient in
                    Button {
                        state.selectedPatient = patient
                    } label: {
                        VStack(spacing: AppSpacing.sm) {
                            PatientProfileCard(patient: patient)

                            if state.selectedPatient?.id == patient.id {
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
                    .buttonStyle(.plain)
                }

                PrimaryButton(title: "Continue", icon: "arrow.right") {
                    onNext()
                }
                .disabled(state.selectedPatient == nil)
                .opacity(state.selectedPatient == nil ? 0.5 : 1)
                .padding(.top, AppSpacing.sm)
            }
            .padding(.top)
            .padding(.bottom, AppSpacing.lg)
        }
        .background(AppColors.background)
    }
}

#Preview {
    SelectPatientView(state: .constant(BookingFlowState())) {}
}
