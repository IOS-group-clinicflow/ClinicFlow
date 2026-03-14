//
//  MockData.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-070 on 2026-03-12.
//

import Foundation

struct MockData {
    
    // Patients
    
    static let currentUser = Patient(
        id: UUID(),
        name: "Kawish Jayawardena",
        relationship: "Self",
        age: 28,
        allergies: ["Penicillin"],
        medicalHistory: ["Appendectomy (2021)"],
        chronicConditions: [],
        emergencyContact: "+94 77 123 4567",
        healthNotes: "No ongoing conditions"
    )
    
    static let linkedPatients: [Patient] = [
        Patient(
            id: UUID(),
            name: "Amara Jayawardena",
            relationship: "Mother",
            age: 58,
            allergies: ["Aspirin", "Sulfa drugs"],
            medicalHistory: ["Hypertension diagnosis (2018)", "Cataract surgery (2023)"],
            chronicConditions: ["Hypertension", "Type 2 Diabetes"],
            emergencyContact: "+94 77 234 5678",
            healthNotes: "Regular BP monitoring required"
        ),
        Patient(
            id: UUID(),
            name: "Dineth Jayawardena",
            relationship: "Brother",
            age: 22,
            allergies: [],
            medicalHistory: ["Fractured wrist (2020)"],
            chronicConditions: [],
            emergencyContact: "+94 77 345 6789",
            healthNotes: "No known conditions"
        )
    ]
    
    static var allPatients: [Patient] {
        [currentUser] + linkedPatients
    }
    
    // Doctors
    
    static let doctors: [Doctor] = [
        Doctor(
            id: UUID(),
            name: "Dr. Nishantha Perera",
            specialty: "General Practitioner",
            availability: "Mon - Fri, 9:00 AM - 5:00 PM",
            channelingFee: 4500,
            imageName: "person.circle.fill"
        ),
        Doctor(
            id: UUID(),
            name: "Dr. Samanthi Silva",
            specialty: "Cardiologist",
            availability: "Tue, Thu, 10:00 AM - 3:00 PM",
            channelingFee: 7800,
            imageName: "person.circle.fill"
        ),
        Doctor(
            id: UUID(),
            name: "Dr. Ruwan Fernando",
            specialty: "Dermatologist",
            availability: "Mon, Wed, Fri, 8:00 AM - 1:00 PM",
            channelingFee: 5600,
            imageName: "person.circle.fill"
        ),
        Doctor(
            id: UUID(),
            name: "Dr. Kavindi Rathnayake",
            specialty: "OBG Specialist",
            availability: "Wed, Fri, 9:00 AM - 2:00 PM",
            channelingFee: 6900,
            imageName: "person.circle.fill"
        ),
        Doctor(
            id: UUID(),
            name: "Dr. Ashan Wijesinghe",
            specialty: "Pediatrician",
            availability: "Mon - Sat, 8:30 AM - 4:00 PM",
            channelingFee: 5000,
            imageName: "person.circle.fill"
        )
    ]
    
    // Appointments
    
    static let upcomingAppointment = Appointment(
        id: UUID(),
        patientName: "Kawish Jayawardena",
        doctorName: "Dr. Nishantha Perera",
        specialty: "General Practitioner",
        date: "15 March 2026",
        time: "10:30 AM",
        location: "Clinic Flow Medical Centre, Colombo 07",
        status: "Confirmed",
        needsPrePayment: false
    )
    
    static let pastAppointments: [Appointment] = [
        Appointment(
            id: UUID(),
            patientName: "Kawish Jayawardena",
            doctorName: "Dr. Samanthi Silva",
            specialty: "Cardiologist",
            date: "28 February 2026",
            time: "11:00 AM",
            location: "Clinic Flow Medical Centre, Colombo 07",
            status: "Completed",
            needsPrePayment: false
        ),
        Appointment(
            id: UUID(),
            patientName: "Amara Jayawardena",
            doctorName: "Dr. Kavindi Rathnayake",
            specialty: "OBG Specialist",
            date: "10 February 2026",
            time: "9:30 AM",
            location: "Clinic Flow Medical Centre, Colombo 07",
            status: "Completed",
            needsPrePayment: true
        )
    ]
    
    // Notifications
    
    static let notifications: [NotificationItem] = [
        NotificationItem(
            id: UUID(),
            title: "Dr. Smith Delay",
            message: "Your 10:30 AM appointment is delayed by 15 mins. New estimated start: 10:45 AM.",
            time: "2m ago",
            category: "delay",
            section: .today,
            isUnread: true
        ),
        NotificationItem(
            id: UUID(),
            title: "Queue Update",
            message: "You are now 3rd in line. Please head towards Waiting Area B.",
            time: "15m ago",
            category: "queue",
            section: .today,
            isUnread: true
        ),
        NotificationItem(
            id: UUID(),
            title: "Appointment Confirmed",
            message: "Your follow-up with Dr. Sarah Chen for tomorrow at 2:00 PM is confirmed.",
            time: "2h ago",
            category: "confirmed",
            section: .today,
            isUnread: true
        ),
        NotificationItem(
            id: UUID(),
            title: "New Lab Results",
            message: "Your blood test results from Oct 24 are now available in your medical records.",
            time: "Yesterday",
            category: "results",
            section: .yesterday,
            isUnread: true
        ),
        NotificationItem(
            id: UUID(),
            title: "Clinic Holiday Notice",
            message: "The clinic will be closed this Friday for the public holiday. Regular hours resume Saturday.",
            time: "Yesterday",
            category: "notice",
            section: .yesterday,
            isUnread: false
        ),
        NotificationItem(
            id: UUID(),
            title: "Weekly Health Tip",
            message: "Staying hydrated helps maintain focus and energy throughout your day. Remember to drink 8 glasses!",
            time: "Oct 22",
            category: "tip",
            section: .earlier,
            isUnread: false
        )
    ]
    
    // Medical Records
    
    static let medicalRecords: [MedicalRecord] = [
        MedicalRecord(
            id: UUID(),
            title: "Full Blood Count",
            type: "Lab Test",
            date: "28 February 2026",
            summary: "All values within normal range. Hemoglobin 14.2 g/dL.",
            status: "Available"
        ),
        MedicalRecord(
            id: UUID(),
            title: "Chest X-Ray",
            type: "Imaging",
            date: "15 January 2026",
            summary: "No abnormalities detected. Lungs clear.",
            status: "Available"
        ),
        MedicalRecord(
            id: UUID(),
            title: "Lipid Panel",
            type: "Lab Test",
            date: "10 March 2026",
            summary: "Pending lab processing.",
            status: "Pending"
        )
    ]
    
    // Lab Tests
    
    static let labTests: [LabTest] = [
        LabTest(
            id: UUID(),
            name: "Full Blood Count",
            location: "Clinic Flow Lab, Colombo 07",
            status: "Completed",
            requiresPayment: false,
            notes: "Routine checkup blood work"
        ),
        LabTest(
            id: UUID(),
            name: "OBG Ultrasound",
            location: "Clinic Flow Imaging, Colombo 07",
            status: "Scheduled",
            requiresPayment: true,
            notes: "Pre-payment required before appointment"
        ),
        LabTest(
            id: UUID(),
            name: "Thyroid Function Test",
            location: "Clinic Flow Lab, Colombo 07",
            status: "Pending",
            requiresPayment: false,
            notes: "Follow-up test requested by cardiologist"
        )
    ]
    
    // Specialties
    
    static let specialties: [String] = [
        "General Practitioner",
        "Cardiologist",
        "Dermatologist",
        "OBG Specialist",
        "Pediatrician",
        "Orthopedic Surgeon",
        "ENT Specialist",
        "Neurologist",
        "Ophthalmologist",
        "Psychiatrist"
    ]
}
