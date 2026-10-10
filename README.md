# NourDoc 2.0

**Flutter Mobile Application · Clinical Workspace UI**

NourDoc 2.0 is a Flutter-based mobile interface designed to demonstrate a connected clinical workflow—from clinician onboarding and patient management to consultations, clinical documentation, report review, and account administration.

The project uses a feature-organized codebase, reusable UI components, and a centralized design system to support consistent interfaces and future backend integration.

> **Development status:** Frontend UI prototype. The repository uses local mock data and simulated interactions. Authentication, clinical AI processing, audio recording, patient-record services, and payment gateways are not connected to production backends.

## Table of Contents

- [Overview](#overview)
- [Technology Stack](#technology-stack)
- [Application Modules](#application-modules)
- [User Journey](#user-journey)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Testing](#testing)
- [Android Build](#android-build)
- [Design System](#design-system)
- [Implementation Status](#implementation-status)
- [Development Notes](#development-notes)
- [References](#references)

## Overview

The application brings several clinician-facing experiences into a single mobile UI. Its current implementation includes **52 registered screen destinations** and a shared five-item navigation shell.

The codebase is organized around the following objectives:

- **Workflow clarity:** Present patient, encounter, and consultation activities in a coherent sequence.
- **Modular implementation:** Group screens by feature so individual workflows can be maintained and extended.
- **Visual consistency:** Reuse theme tokens and shared components across the application.
- **Integration readiness:** Separate demonstration data from UI structure, providing a foundation for introducing backend services in subsequent development.

## Technology Stack

| Component | Technology |
| --- | --- |
| Application framework | Flutter / Dart |
| Dart SDK constraint | `^3.8.1` |
| UI foundation | Material 3 with custom theming |
| Typography | Inter via `google_fonts: ^6.3.2` |
| Formatting | `intl: ^0.20.2` |
| Icons | Material and `cupertino_icons: ^1.0.8` |
| Navigation | Named routes, `MaterialApp`, and a custom bottom-navigation shell |
| Demonstration data | In-repository Dart mock models and records |
| Quality tooling | `flutter_test` and `flutter_lints` |

The repository includes Flutter platform runner directories for Android, iOS, web, Windows, macOS, and Linux. The interface is primarily designed for mobile screen sizes.

## Application Modules

| Module | Included interfaces |
| --- | --- |
| **Onboarding and Access** | Splash, onboarding, sign-in, verification, and clinician registration |
| **Clinical Workspace** | Dashboard, consultation list, notifications, and empty/error states |
| **Patient Management** | Patient search, profile, medical timeline, and previous reports |
| **Encounter Setup** | Patient selection, care setting, intake/vitals, and clinical context |
| **Recording Workflow** | Ready, active, paused, submitted, and AI-processing states |
| **Clinical Documentation** | Consultation details, report overview, SOAP, ICD-10/CPT views, evidence mapping, transcripts, risk review, and final review |
| **Plans and Billing** | Plans, comparisons, subscriptions, usage, payment-method UI, payment states, and invoices |
| **Account Settings** | Profile, general settings, notification preferences, and security |

These modules represent UI screens and demonstration flows; they do not imply that corresponding external services are already active.

## User Journey

The following diagram summarizes the major screens and navigation paths.

```text
Splash
  └── Onboarding
       └── Sign In / Verification
            └── Main Navigation
                 ├── Home
                 │    └── Clinical Workspace
                 ├── Schedule
                 │    └── Consultations
                 ├── Encounter (+)
                 │    └── Select Patient
                 │         └── Care Setting
                 │              └── Intake & Vitals
                 │                   └── Clinical Context
                 │                        └── Recording
                 │                             └── Submission
                 │                                  └── AI Processing UI
                 │                                       └── Consultation / Report Review
                 ├── Patients
                 │    ├── Search & Profile
                 │    ├── Timeline
                 │    └── Previous Reports
                 └── Profile
                      ├── Settings
                      ├── Subscription
                      └── Billing

Clinical Report Review
  ├── Overview
  ├── SOAP Documentation
  ├── ICD-10 / CPT Coding
  ├── Evidence & Transcript Mapping
  ├── Clinical Risk Review
  ├── Transcript
  └── Final Clinical Review
```

The main navigation contains **Home**, **Schedule**, **Encounter**, **Patients**, and **Profile**. The central Encounter action begins patient selection; the remaining tabs use an `IndexedStack` to manage views.

The flow above is a conceptual overview of available navigation rather than a guarantee that all demo screens persist information end to end.

## Project Structure

The following tree highlights the principal source directories, feature modules, and representative screens in the repository.

```text
nourdoc-2.0-ui/
├── android/                           # Android runner
├── ios/                               # iOS runner
├── linux/                             # Linux runner
├── macos/                             # macOS runner
├── web/                               # Web runner
├── windows/                           # Windows runner
├── assets/
│   └── images/                        # Application image assets
├── lib/
│   ├── main.dart                      # Application entry point
│   ├── app/
│   │   ├── app.dart                   # App configuration and route handling
│   │   ├── routes/
│   │   │   └── app_routes.dart        # Named route definitions
│   │   └── navigation/
│   │       └── main_nav_shell.dart    # Bottom navigation shell
│   ├── core/
│   │   └── theme/
│   │       ├── app_colors.dart        # Color palette
│   │       ├── app_typography.dart    # Typography styles
│   │       ├── app_spacing.dart       # Spacing tokens
│   │       ├── app_radius.dart        # Radius tokens
│   │       ├── app_shadows.dart       # Shadow styles
│   │       └── app_theme.dart         # Theme configuration
│   ├── models/
│   │   └── mock/
│   │       ├── mock_models.dart       # Demo data models
│   │       └── mock_data.dart         # Demo records
│   ├── shared/
│   │   └── widgets/
│   │       ├── app_button.dart
│   │       ├── app_text_field.dart
│   │       ├── brand_logo.dart
│   │       ├── clinical_badges.dart
│   │       └── organic_waveform.dart
│   └── features/
│       ├── auth/                       # Splash, onboarding, sign-in, registration
│       ├── workspace/                  # Dashboard and UI states
│       ├── patients/                   # Search, profile, timeline, reports
│       ├── encounters/                 # Patient selection, intake, context
│       ├── recording/                  # Recording and submission states
│       ├── processing/                 # AI-processing interface
│       ├── consultations/              # Consultation list and details
│       ├── reports/                    # Documentation and report review
│       ├── clinical_risk/              # Risk overview and details
│       ├── subscription/               # Plans and subscription screens
│       ├── billing/                    # Payment and invoice screens
│       └── profile/                    # Profile, settings, security
├── test/
│   └── widget_test.dart               # Widget and viewport tests
├── analysis_options.yaml             # Static analysis rules
├── pubspec.yaml                      # Dependencies and assets
├── pubspec.lock                      # Resolved dependency versions
├── NourDoc_New_Flutter_UI_From_Scratch_Master_Prompt.md
└── README.md
```

**Directory responsibilities**

- `lib/app/` — Root application setup, route declarations, and navigation behavior.
- `lib/core/theme/` — Reusable visual tokens and Flutter theme definitions.
- `lib/features/` — Screens grouped by functional domain.
- `lib/models/mock/` — Models and static data used by the prototype.
- `lib/shared/widgets/` — UI components shared across feature screens.
- `test/` — Automated widget tests.

> The tree is a concise structural overview, not a complete listing of every file under each directory. It does not assume any API, repository, controller, or service layers that are not present in the source.

## Getting Started

### Prerequisites

Install and configure:

- Flutter SDK with a Dart version compatible with `^3.8.1`.
- Android Studio or Visual Studio Code with Flutter/Dart extensions.
- An Android emulator or connected Android device. For iOS, use a compatible macOS environment.

### Installation

**1. Clone the repository**

```bash
git clone https://github.com/mnoumanrasheed/nourdoc-2.0-ui.git
cd nourdoc-2.0-ui
```

**2. Verify the Flutter environment and install dependencies**

```bash
flutter doctor
flutter pub get
```

**3. Run the application**

```bash
flutter devices
flutter run
```

To select a device explicitly:

```bash
flutter run -d <device_id>
```

Replace `<device_id>` with an identifier returned by `flutter devices`.

**Demo access:** The sign-in UI provides a **Direct Demo Access** option for entering the clinical workspace without connecting to an authentication service.

## Testing

Run Flutter static analysis and the test suite:

```bash
flutter analyze
flutter test
```

The repository includes a basic splash/onboarding smoke test and widget tests configured for several mobile viewports:

| Viewport | Dimensions |
| --- | --- |
| Compact phone | `375 × 812` |
| Primary design viewport | `390 × 844` |
| Standard phone | `393 × 852` |
| Large phone | `430 × 932` |

These checks are defined in the repository. Execute them locally or in CI to verify the current build; their passing status is not asserted here.

## Android Build

Build a release APK:

```bash
flutter pub get
flutter build apk --release
```

Expected output:

```text
build/app/outputs/flutter-apk/app-release.apk
```

Build an Android App Bundle (AAB):

```bash
flutter build appbundle --release
```

Before public distribution, review application identifiers, release signing, versioning, and production integrations. The release artifact built from the current source remains a UI demonstration.

## Design System

NourDoc uses a restrained clinical visual style with centralized color, typography, spacing, corner-radius, and shadow definitions.

| Design token | Value | Usage |
| --- | --- | --- |
| Deep Jade | `#286252` | Primary brand elements and actions |
| Fresh Jade | `#3F8F82` | Secondary accents |
| Pale Jade | `#EAF4F1` | Subtle backgrounds |
| Clinical Blue | `#477C9B` | Informational UI |
| Warm Amber | `#D9A441` | Processing and attention states |
| Rose | `#C85C5C` | Risk and error states |
| Charcoal | `#24343B` | Primary text |

Theme definitions reside in `lib/core/theme/`. Local application images are registered through `pubspec.yaml`.

## Implementation Status

| Capability | Current status |
| --- | --- |
| UI screens and navigation | Implemented as a Flutter prototype |
| Patient and consultation content | Local demonstration data |
| Clinical reports and coding views | Demonstration interfaces |
| Recording timer and visual waveform | Simulated UI states |
| AI processing and generated outputs | Demonstration interfaces |
| Sign-in and clinician verification | UI flow only |
| Payment methods and billing | UI flow only; no live transactions |
| Backend services and persistent records | Not integrated |

The prototype is intended for interface review, workflow validation, and frontend development. It is **not suitable for clinical decision-making or processing real patient/payment information** in its current form.

## Development Notes

For subsequent integration work, the existing feature organization can be retained while introducing backend clients, repositories, request/response models, and state management as appropriate to approved APIs.

Recommended integration sequence:

1. Define API contracts, authentication requirements, and secure data-handling rules.
2. Replace relevant mock records with repository-backed data sources.
3. Connect encounter and report workflows with appropriate loading/error states.
4. Integrate audio, clinical processing, and billing only after corresponding services are available and validated.
5. Add integration tests, auditability, and production security controls before deployment.

No backend architecture or external integration described above should be assumed to exist in this repository today.

## References

- **Repository:** [github.com/mnoumanrasheed/nourdoc-2.0-ui](https://github.com/mnoumanrasheed/nourdoc-2.0-ui)
- **UI implementation brief:** [`NourDoc_New_Flutter_UI_From_Scratch_Master_Prompt.md`](NourDoc_New_Flutter_UI_From_Scratch_Master_Prompt.md)
- **Design reference:** [NourDoc Figma project](https://www.figma.com/make/VTbiUqbOfOwTP4G9HYNelw/NourDoc-Mobile-UI-UX-Design?t=pFaUl0ovGqMxlV4B-1)

---

**Project:** NourDoc 2.0  
**Package:** `nourdoc`  
**Repository type:** Flutter UI prototype
