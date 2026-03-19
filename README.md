# Clinic Flow – iOS UI Prototype

Clinic Flow is a SwiftUI-based iOS prototype that reimagines how patients interact with clinics.

It focuses on one thing: making appointments, queue tracking, and medical access simple and stress-free.

This project is built as a **UI-first prototype**.
There is no backend. No real data. Just a clear, complete user experience.

---

## What this project shows

You can walk through a full patient journey from start to finish.

From opening the app…
to booking an appointment…
to tracking your queue…
to reviewing your records.

All inside a clean, patient-friendly interface.

---

## Key features

* Appointment booking flow
* Book for yourself or family members
* Live queue tracking
* Visit history and details
* Medical records and test results
* Conditional payment flow (only when required)
* Notifications and reminders
* Profile and linked patient management

---

## Why this project exists

Most clinic systems feel confusing, slow, or stressful.

You know the feeling.
Waiting without updates.
Repeating the same details again and again.

Clinic Flow tries to fix that.

It brings everything into one place:

* bookings
* queue visibility
* records
* patient profiles

---

## Built with

* SwiftUI (Apple’s modern UI framework)
* Xcode
* Mock data (no backend integration)

---

## Design approach

The app follows **Apple Human Interface Guidelines**.

That means:

* clean layouts
* large, readable text
* proper spacing
* familiar iOS navigation patterns

It also supports:

* Dark Mode
* Accessibility-friendly UI
* Simple, patient-first language

---

## App flow (high-level)

**Entry flow**
Splash → Welcome → Login → Privacy

**Main app**
Home → Visits → Records → Notifications → Profile

**Booking flow**
Select Patient → Choose Doctor → Pick Date & Time → Confirm → Payment (if needed)

---

## Special focus areas

### 1. Booking for others

You can book appointments for:

* yourself
* a child
* a parent
* a spouse

This reflects real clinic use, not just single-user apps.

---

### 2. Conditional payments

Not every appointment needs payment.

The prototype shows:

* a normal booking flow (no payment)
* a payment-required flow (e.g. ultrasound)

This makes the experience more realistic.

---

### 3. Medical profiles

Each patient profile includes:

* allergies
* medical history
* conditions
* emergency contact

So the app feels like an actual healthcare tool, not just a booking app.

---

## Project structure

The project is organized for clarity and scalability:

* App (entry and root navigation)
* Models (data structures)
* MockData (sample data)
* Theme (colors, typography, spacing)
* Components (reusable UI elements)
* Features (screen-based modules)

Each screen is built as a separate SwiftUI view.

---

## Limitations

* No backend or API integration
* No real authentication
* Data is fully hardcoded

This project focuses only on UI and user experience.

---

## How to run

1. Open the project in Xcode
2. Select an iOS simulator
3. Run the app

---

## Final note

This is done for a coursework project, only the UI and interaction workflow is needed to display how an application can be presented.
