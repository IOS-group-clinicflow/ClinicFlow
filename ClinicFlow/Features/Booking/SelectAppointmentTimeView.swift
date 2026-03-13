//
//  SelectAppointmentTimeView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct SelectAppointmentTimeView: View {
    @Binding var state: BookingFlowState
    let onBack: () -> Void
    let onNext: () -> Void

    private let timeSlots = [
        "08:30 AM", "09:00 AM", "09:30 AM", "10:00 AM",
        "10:30 AM", "11:00 AM", "11:30 AM", "12:00 PM",
        "02:00 PM", "02:30 PM", "03:00 PM", "03:30 PM"
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.sectionSpacing) {
                if let selectedDate = state.selectedDate {
                    HStack {
                        Text("Selected Date")
                            .font(AppTypography.subheadline)
                            .foregroundColor(AppColors.textSecondary)
                        Spacer()
                        TagView(text: selectedDate.formatted(.dateTime.day().month().year()))
                    }
                    .padding(.horizontal, AppSpacing.screenHorizontal)
                }

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: AppSpacing.md)], spacing: AppSpacing.md) {
                    ForEach(timeSlots, id: \.self) { slot in
                        Button {
                            state.selectedTime = slot
                        } label: {
                            Text(slot)
                                .font(AppTypography.subheadline)
                                .foregroundColor(state.selectedTime == slot ? .white : AppColors.textPrimary)
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                                .background(state.selectedTime == slot ? AppColors.primary : AppColors.cardBackground)
                                .cornerRadius(AppSpacing.cornerRadiusSmall)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, AppSpacing.screenHorizontal)

                HStack(spacing: AppSpacing.md) {
                    SecondaryButton(title: "Back", action: onBack)
                    PrimaryButton(title: "Continue", icon: "arrow.right", action: onNext)
                        .disabled(state.selectedTime == nil)
                        .opacity(state.selectedTime == nil ? 0.5 : 1)
                }
            }
            .padding(.top)
            .padding(.bottom, AppSpacing.lg)
        }
        .background(AppColors.background)
    }
}

#Preview {
    SelectAppointmentTimeView(state: .constant(BookingFlowState()), onBack: {}) {}
}
