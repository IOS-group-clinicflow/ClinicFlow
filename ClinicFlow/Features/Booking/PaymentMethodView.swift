//
//  PaymentMethodView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct PaymentMethodView: View {
    @Binding var state: BookingFlowState
    let onBack: () -> Void
    let onPay: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.sectionSpacing) {
                Text("Select a payment method to complete your booking.")
                    .font(AppTypography.body)
                    .foregroundColor(AppColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, AppSpacing.screenHorizontal)

                ForEach(PaymentMethod.allCases) { method in
                    Button {
                        state.selectedPaymentMethod = method
                    } label: {
                        HStack {
                            Text(method.rawValue)
                                .font(AppTypography.body)
                                .foregroundColor(AppColors.textPrimary)

                            Spacer()

                            if state.selectedPaymentMethod == method {
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
                    PrimaryButton(title: "Pay & Confirm", icon: "checkmark", action: onPay)
                        .disabled(state.selectedPaymentMethod == nil)
                        .opacity(state.selectedPaymentMethod == nil ? 0.5 : 1)
                }
            }
            .padding(.top)
            .padding(.bottom, AppSpacing.lg)
        }
        .background(AppColors.background)
    }
}

#Preview {
    PaymentMethodView(state: .constant(BookingFlowState()), onBack: {}) {}
}
