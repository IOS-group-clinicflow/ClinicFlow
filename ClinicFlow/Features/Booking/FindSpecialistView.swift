//
//  FindSpecialistView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct FindSpecialistView: View {
    @Binding var state: BookingFlowState
    let onBack: () -> Void
    let onNext: () -> Void

    @State private var searchText = ""

    private var filteredSpecialties: [String] {
        guard !searchText.isEmpty else { return MockData.specialties }

        return MockData.specialties.filter {
            $0.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.sectionSpacing) {
                SearchBarView(text: $searchText, placeholder: "Search specialty")

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: AppSpacing.md)], spacing: AppSpacing.md) {
                    ForEach(filteredSpecialties, id: \.self) { specialty in
                        Button {
                            state.selectedSpecialty = specialty
                        } label: {
                            VStack(spacing: AppSpacing.xs) {
                                SpecialistTile(
                                    specialty: specialty,
                                    icon: SpecialistTile.iconFor(specialty)
                                )

                                if state.selectedSpecialty == specialty {
                                    StatusBadge(text: "Selected", style: .success)
                                }
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, AppSpacing.screenHorizontal)

                HStack(spacing: AppSpacing.md) {
                    SecondaryButton(title: "Back", action: onBack)
                    PrimaryButton(title: "Continue", icon: "arrow.right", action: onNext)
                        .disabled(state.selectedSpecialty == nil)
                        .opacity(state.selectedSpecialty == nil ? 0.5 : 1)
                }
            }
            .padding(.top)
            .padding(.bottom, AppSpacing.lg)
        }
        .background(AppColors.background)
    }
}

#Preview {
    FindSpecialistView(state: .constant(BookingFlowState()), onBack: {}) {}
}
