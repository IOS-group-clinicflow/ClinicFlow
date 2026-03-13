//
//  LinkedProfilesView.swift
//  ClinicFlow
//
//  Created by Kawish Jayawardena on 2026-03-13.
//

import SwiftUI

struct LinkedProfilesView: View {
    @State private var searchText = ""

    private var filteredPatients: [Patient] {
        guard !searchText.isEmpty else { return MockData.linkedPatients }
        return MockData.linkedPatients.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
                || $0.relationship.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: AppSpacing.sectionSpacing) {
                SearchBarView(text: $searchText, placeholder: "Search linked profiles")

                if filteredPatients.isEmpty {
                    EmptyStateView(
                        icon: "person.2.slash",
                        title: "No Linked Profiles",
                        message: "Add family members to book appointments on their behalf."
                    )
                } else {
                    ForEach(filteredPatients) { patient in
                        NavigationLink {
                            PatientDetailsView(patient: patient)
                        } label: {
                            PatientProfileCard(patient: patient, onTap: nil)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.top)
            .padding(.bottom, AppSpacing.lg)
        }
        .background(AppColors.background)
        .navigationTitle("Linked Profiles")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LinkedProfilesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LinkedProfilesView()
        }
    }
}
