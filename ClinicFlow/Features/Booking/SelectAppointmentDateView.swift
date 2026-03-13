//
//  SelectAppointmentDateView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct SelectAppointmentDateView: View {
    @Binding var state: BookingFlowState
    let onBack: () -> Void
    let onNext: () -> Void

    private var upcomingDates: [Date] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return (1...10).compactMap { calendar.date(byAdding: .day, value: $0, to: today) }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.sectionSpacing) {
                Text("Choose an available appointment date.")
                    .font(AppTypography.body)
                    .foregroundColor(AppColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, AppSpacing.screenHorizontal)

                ForEach(upcomingDates, id: \.self) { date in
                    Button {
                        state.selectedDate = date
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                                Text(date.formatted(.dateTime.weekday(.wide)))
                                    .font(AppTypography.headline)
                                    .foregroundColor(AppColors.textPrimary)

                                Text(date.formatted(.dateTime.day().month().year()))
                                    .font(AppTypography.subheadline)
                                    .foregroundColor(AppColors.textSecondary)
                            }

                            Spacer()

                            if Calendar.current.isDate(state.selectedDate ?? .distantPast, inSameDayAs: date) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(AppColors.success)
                            }
                        }
                        .padding(AppSpacing.cardPadding)
                        .background(AppColors.cardBackground)
                        .cornerRadius(AppSpacing.cornerRadiusMedium)
                        .padding(.horizontal, AppSpacing.screenHorizontal)
                    }
                    .buttonStyle(.plain)
                }

                HStack(spacing: AppSpacing.md) {
                    SecondaryButton(title: "Back", action: onBack)
                    PrimaryButton(title: "Continue", icon: "arrow.right", action: onNext)
                        .disabled(state.selectedDate == nil)
                        .opacity(state.selectedDate == nil ? 0.5 : 1)
                }
            }
            .padding(.top)
            .padding(.bottom, AppSpacing.lg)
        }
        .background(AppColors.background)
    }
}

#Preview {
    SelectAppointmentDateView(state: .constant(BookingFlowState()), onBack: {}) {}
}
