# NOURDOC 2.0 — Flutter UI Implementation Master Prompt

## ROLE

Act as a **Senior Flutter UI Engineer, Mobile Design Systems Architect, and Pixel-Accurate Figma-to-Flutter Specialist**.

Your task is to implement the **complete NOURDOC 2.0 mobile application UI in Flutter** based on the supplied Figma design and the NOURDOC 2.0 UI/UX specification.

You are NOT designing a new product.

You are NOT allowed to reinterpret the visual direction.

You are NOT allowed to redesign screens according to your own taste.

Your responsibility is to translate the approved design into a **clean, reusable, responsive, production-quality Flutter UI codebase**.

---

# 1. PRIMARY OBJECTIVE

Build the NOURDOC mobile UI so that it matches the approved Figma design **screen-for-screen and as pixel-accurately as technically possible**.

The Figma design is not inspiration. It is the target UI.

The final Flutter app should feel like:

- Apple-level simplicity
- Premium healthcare SaaS
- Clinical intelligence
- Human-centered design
- Calm, trustworthy, modern medical software
- Investor-ready
- Hospital-ready
- Enterprise-ready
- Developer-ready

The application represents:

> **NOURDOC INTELLIGENT CLINICAL WORKSPACE**

NourDoc is not simply an AI transcription app.

The UI must communicate a complete clinical workflow:

**Patient → Care Setting → Clinical Encounter → Conversation → AI Processing → Clinical Documentation → SOAP → ICD-10/CPT → Evidence → Clinical Risk Review → Clinician Review → Longitudinal Patient Record**

---

# 1.1 NEW PROJECT REQUIREMENT

Create the application as a **new Flutter project from scratch**.

Recommended project/package naming:

```text
Project: nourdoc
Package: com.nourdoc.app
```

If a different package identifier is required by the environment, keep the visible product name **NourDoc**.

The initial deliverable must be a runnable mobile UI project with:

- Android support
- iOS-compatible Flutter structure
- null safety
- Material 3 only where it does not visually override the Figma design
- reusable custom NourDoc components instead of default Material appearance
- local mock data
- working local navigation

Do not wait for backend APIs before implementing the complete UI.

---

# 2. SOURCE OF TRUTH — STRICT PRIORITY

Use the following order whenever there is any conflict:

1. **Approved Figma design**
2. **NOURDOC 2.0 UI/UX specification**
3. Official NourDoc assets supplied with the task
4. This implementation specification

Figma link:

`https://www.figma.com/make/VTbiUqbOfOwTP4G9HYNelw/NourDoc-Mobile-UI-UX-Design?t=pFaUl0ovGqMxlV4B-1`

### Important

If the exact Figma visual can be inspected, reproduce it faithfully.

Do NOT replace an approved Figma layout with a generic Flutter/Material design.

Do NOT invent a new design because it is easier to code.

If an exact visual detail is unavailable, use the NOURDOC design system defined in this prompt and keep the implementation visually consistent with already completed screens.

---

# 3. PROJECT MODE — BUILD FROM SCRATCH

There is **NO existing Flutter repository or application to modify**.

Create a **brand-new Flutter mobile application from scratch** for NOURDOC 2.0.

Start by creating a clean Flutter project and establish the full UI architecture, theme, navigation, reusable component system, assets structure, mock models, and all required screens.

This phase is **frontend UI implementation only**.

## DO

Implement:

- Screens
- Layouts
- Navigation
- Reusable widgets
- Form UI
- Mock interactions
- Mock state changes
- Local dummy/mock data
- Tabs
- Filters
- Chips
- Dialogs
- Bottom sheets where visually required
- Animations
- Loading states
- Empty states
- Error states
- Responsive behavior
- Theme
- Typography
- Icons
- Local assets
- Visual validation

## DO NOT

Do NOT implement:

- Backend
- REST APIs
- GraphQL
- Firebase
- Supabase
- Authentication APIs
- Database
- Payment gateway logic
- Stripe integration
- JazzCash integration
- EasyPaisa integration
- Bank verification logic
- Audio upload APIs
- AI APIs
- Speech-to-text APIs
- Clinical processing APIs
- Server state
- Real patient data
- Real medical coding service
- Real subscription management

For now, all dynamic content should use **mock/local models and realistic sample data**.

The UI architecture must make future API integration easy, but API integration itself is out of scope.

---

# 4. NON-NEGOTIABLE RULES

1. Do not redesign the approved Figma.
2. Do not simplify screens merely to save development time.
3. Do not remove sections from the provided product flow.
4. Do not use random colors.
5. Do not use random font sizes.
6. Do not duplicate styling values across files.
7. Do not build each screen independently with inconsistent components.
8. Do not hardcode repeated visual values throughout the code.
9. Do not use excessive gradients.
10. Do not use excessive shadows.
11. Do not use excessive glassmorphism.
12. Do not use neon/futuristic AI styling.
13. Do not use generic hospital-dashboard styling.
14. Do not use generic robot illustrations.
15. Do not rely on color alone for status communication.
16. Do not introduce backend packages unnecessarily.
17. Do not leave obvious placeholder Flutter default widgets where a designed component exists.
18. Do not mark work complete if overflow, broken navigation, alignment issues, or inconsistent styling remain.
19. Do not silently skip screens.
20. Every task must be checked in the completion checklist before final handoff.

---

# 5. BRAND SYSTEM

## Product

**NourDoc**

## Primary Brand Color

```text
Deep Jade
#286252
```

## Supporting Colors

```text
Fresh Jade
#3F8F82

Pale Jade
#EAF4F1

Clinical Mist
#F6F9F8

Clinical Blue
#477C9B

Soft Blue
#EAF2F7

Warm Amber
#D9A441

Rose
#C85C5C

Indigo
#625B9A

Charcoal
#24343B

Slate
#607078

White
#FFFFFF
```

## Semantic Meaning

- Jade = primary / normal clinical action
- Blue = information
- Amber = processing / attention
- Rose = risk / urgent attention
- Indigo = OT / surgical context

Use semantic colors consistently.

---

# 6. VISUAL LANGUAGE

The UI must feel:

- Professional
- Premium
- Calm
- Clinical
- Intelligent
- Human
- Trustworthy
- Modern
- Minimal
- Highly usable

Use the NourDoc logo's visual DNA through:

- Organic curves
- Circuit-tree patterns
- Connected nodes
- Flowing lines
- Thin clinical line art
- Subtle AI/technology motifs

Use these especially in:

- Onboarding
- Recording
- AI processing
- Report generation
- Empty states
- Clinical intelligence
- Subscription screens
- Loading states

Do not repeatedly place the full logo everywhere.

---

# 7. TYPOGRAPHY

Primary typeface:

**Inter**

Alternative only if necessary:

**Manrope**

Suggested hierarchy:

```text
Page Title       24–28
Section Heading  18–20
Card Title       15–17
Body             14–16
Metadata         12–13
```

Define the real Flutter text styles centrally.

Create semantic styles such as:

- display
- pageTitle
- sectionTitle
- cardTitle
- bodyLarge
- body
- label
- metadata
- button
- caption

Do not scatter raw `TextStyle()` definitions throughout screens.

---

# 8. FLUTTER DESIGN SYSTEM

Create a centralized design system before implementing the majority of screens.

Recommended structure:

```text
lib/
├── app/
│   ├── app.dart
│   ├── routes/
│   └── navigation/
│
├── core/
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_typography.dart
│   │   ├── app_spacing.dart
│   │   ├── app_radius.dart
│   │   ├── app_shadows.dart
│   │   ├── app_sizes.dart
│   │   └── app_theme.dart
│   │
│   ├── assets/
│   ├── constants/
│   └── widgets/
│
├── features/
│   ├── onboarding/
│   ├── auth/
│   ├── workspace/
│   ├── patients/
│   ├── encounters/
│   ├── recording/
│   ├── processing/
│   ├── consultations/
│   ├── reports/
│   ├── coding/
│   ├── evidence/
│   ├── clinical_risk/
│   ├── subscription/
│   ├── billing/
│   └── profile/
│
├── models/
│   └── mock/
│
└── shared/
    └── widgets/
```

Use this as the preferred starting architecture for the new project. Keep it pragmatic and UI-focused; do not over-engineer the application.

---

# 9. REQUIRED GLOBAL TOKENS

Centralize at minimum:

- Colors
- Text styles
- Font weights
- Spacing
- Border radius
- Border colors
- Shadows
- Icon sizes
- Button heights
- Input heights
- Card padding
- App bar dimensions
- Navigation dimensions
- Status colors
- Animation durations
- Screen horizontal padding

Use a consistent spacing scale such as:

```text
4
8
12
16
20
24
32
40
48
```

However, where the Figma clearly uses different measurements, **Figma wins**.

---

# 10. RESPONSIVENESS

Primary Figma reference:

```text
390 × 844
```

Also support:

```text
375 × 812
393 × 852
430 × 932
```

The UI must remain visually correct on common Android and iOS phone sizes.

Use:

- `SafeArea`
- `MediaQuery`
- `LayoutBuilder`
- `Flexible`
- `Expanded`
- `ConstrainedBox`
- `AspectRatio`
- proper scroll behavior
- keyboard-safe forms

Avoid:

- arbitrary absolute positioning for complete layouts
- fixed screen heights that cause overflow
- device-specific hacks
- repeated `MediaQuery` calculations when reusable layout utilities are more appropriate

No screen should produce:

- yellow/black overflow stripes
- clipped text
- hidden CTA buttons
- unusable keyboard overlap
- broken bottom navigation
- stretched illustrations
- inconsistent card widths

---

# 11. REUSABLE COMPONENTS — REQUIRED

Build reusable widgets before duplicating UI.

At minimum create reusable implementations for:

## Buttons

- Primary
- Secondary
- Tertiary
- Destructive
- Icon button
- Loading button

## Inputs

- Text input
- Search input
- Dropdown/select
- Date input
- Clinical numeric input
- Phone field
- Multiline notes field

## Cards

- Patient card
- Encounter card
- Report card
- Risk card
- Evidence card
- Coding card
- Metric card
- Subscription card
- Payment method card

## Navigation

- Top navigation
- Bottom navigation
- Central New Encounter action
- Tabs
- Filter chips
- Section tabs

## Clinical

- Vitals card
- Care-setting card
- Visit-type selector
- Clinical status chip
- Risk signal
- AI confidence badge
- ICD-10 card
- CPT card
- SOAP section
- Timeline item
- Transcript row
- Audio player

## Subscription

- Plan card
- Feature row
- Price display
- Usage indicator
- Payment method card
- Invoice row
- Subscription status
- Upgrade CTA

Do not duplicate near-identical widgets across feature folders.

---

# 12. PRIMARY NAVIGATION

Bottom navigation must contain:

- Home
- Consultations
- Patients
- Profile

The primary central clinical action is:

**New Encounter**

It should remain visually prominent and should match the approved Figma design.

Navigation interactions should work using local routes even though backend functionality is not connected.

---

# 13. REQUIRED SCREEN SET

Implement and validate all required UI screens.

## FOUNDATION / AUTH

- [ ] 01. Splash
- [ ] 02. Welcome / Onboarding
- [ ] 03. Sign In
- [ ] 04. Verification
- [ ] 05. Doctor Registration

## CLINICAL WORKSPACE

- [ ] 06. Clinical Workspace
- [ ] 07. Notifications
- [ ] 08. Patient Search
- [ ] 09. Patient Profile
- [ ] 10. Patient Timeline
- [ ] 11. Previous Reports
- [ ] 12. New Encounter — Select Patient
- [ ] 13. New Encounter — Care Setting
- [ ] 14. Patient Intake
- [ ] 15. Previous Clinical Context
- [ ] 16. Recording — Ready
- [ ] 17. Recording — In Progress
- [ ] 18. Recording — Paused
- [ ] 19. Consultation Submitted
- [ ] 20. AI Processing
- [ ] 21. Consultations
- [ ] 22. Consultation Detail

## REPORT

- [ ] 23. Patient Report — Overview
- [ ] 24. Patient Report — SOAP
- [ ] 25. Patient Report — ICD-10 + CPT
- [ ] 26. Patient Report — Evidence
- [ ] 27. Evidence ↔ Transcript
- [ ] 28. Patient Report — AI Clinical Risk
- [ ] 29. Risk Signal Detail
- [ ] 30. Patient Report — Transcript
- [ ] 31. Final Clinical Review

## SUBSCRIPTION / BILLING

- [ ] 32. Experience NourDoc — Plans
- [ ] 33. Plan Detail
- [ ] 34. Compare Plans
- [ ] 35. Upgrade Plan
- [ ] 36. My Subscription
- [ ] 37. Payment Method Selection
- [ ] 38. Stripe Payment State
- [ ] 39. JazzCash Payment State
- [ ] 40. EasyPaisa Payment State
- [ ] 41. Bank Transfer Instructions
- [ ] 42. Payment Pending
- [ ] 43. Payment Successful
- [ ] 44. Payment Failed
- [ ] 45. Invoice History
- [ ] 46. Usage / Plan Limits

## ACCOUNT

- [ ] 47. Profile
- [ ] 48. Settings
- [ ] 49. Notification Settings
- [ ] 50. Security
- [ ] 51. Empty States
- [ ] 52. Error States

Do not claim completion until every applicable checkbox has been verified.

---

# 14. KEY SCREEN REQUIREMENTS

## Clinical Workspace

Must clearly answer:

> What needs my attention?

Include:

- NourDoc identity
- Notification access
- Doctor avatar
- Greeting
- Daily metrics
- Needs Attention section
- Today's Encounters
- Filters
- Primary New Encounter action

Analytics must remain secondary.

---

## Patient Search

Support UI for search by:

- Name
- Phone
- Patient ID
- Previous consultation

Mock result example may include:

- Patient name
- Age
- Gender
- Patient ID
- Last seen
- Number of previous consultations
- View Patient
- Start Encounter

---

## Care Setting

Question:

> Where is this patient being seen?

Show:

- Emergency
- OPD
- IPD
- OT

Semantic visual treatment:

- Emergency = Rose
- OPD = Deep Jade
- IPD = Clinical Blue
- OT = Indigo

Selected care setting should remain visually identifiable in the encounter flow.

---

## Patient Intake

UI fields:

- Patient Name
- Phone Number
- Age
- Gender
- Temperature
- Pulse
- Respiration
- Blood Pressure
- Blood Sugar
- Visit Type
- New / Follow-up

Use compact clinical cards.

---

## Patient Profile

The patient is the longitudinal clinical entity.

Use tabs:

- Overview
- History
- Reports
- Timeline

Primary action:

**New Consultation**

---

## Recording

This is a signature NourDoc screen.

Must include:

- Patient/context header
- Care setting
- Visit type
- Gender
- Age
- "NourDoc is listening"
- Recording state
- Timer
- Organic audio visualization
- Remaining time
- Discard
- Pause/Resume
- Finish Consultation

**Finish Consultation** is the dominant action.

Do not use "Save Audio".

Use local timer/state simulation only.

No real recording API is required in this phase.

---

## AI Processing

Headline:

> NourDoc is preparing your clinical report

Represent staged mock processing:

- Conversation captured
- Audio processed
- Clinical information extracted
- SOAP note generated
- Coding suggestions prepared
- Evidence identified
- Clinical risk review prepared

Use NourDoc organic/circuit visual language.

Avoid a generic spinner-only design.

Processing may be simulated locally.

---

## Consultations

Include:

- Search
- All
- Today
- Processing
- Ready
- Delayed

Each consultation card should visually support:

- Patient
- Visit type
- Care setting
- Gender
- Age
- Date/time
- Duration
- Status

---

# 15. REPORT SYSTEM

The Patient Report must provide sections for:

- Overview
- SOAP
- Coding
- Evidence
- Clinical Risk
- Transcript

Header should support:

- Patient
- Age / Gender
- Care Setting
- Visit Type
- Date/time
- Consultation duration
- Status

Local UI actions:

- Edit
- Export
- Share
- Play Audio

These may use local placeholder actions/snackbars for this UI phase.

---

# 16. SOAP

Provide structured sections:

- S — Subjective
- O — Objective
- A — Assessment
- P — Plan

The interface must prioritize clinical readability.

---

# 17. CODING UI

Support separate visual treatment for:

- ICD-10
- CPT

Show:

- Code
- Description
- AI Suggested state
- Review & Confirm action

Important:

The interface must visually communicate that the clinician retains control of final coding.

No actual coding API is required.

---

# 18. EVIDENCE

Separate:

- Patient Evidence
- External Reference
- AI Interpretation

The design should visually support traceability:

**AI conclusion → Clinical evidence → Original conversation**

Timestamp interaction can navigate locally to a mocked transcript/audio location.

---

# 19. AI CLINICAL RISK

Do not use one simplistic overall numerical risk score.

Display individual signals requiring review.

Examples:

- Medication risk
- Follow-up risk
- Missing documentation

The visual system must communicate:

> No AI signal does not mean no clinical risk.

Use calm but clear hierarchy.

---

# 20. RISK DETAIL

Support UI for:

- Risk signal
- Why flagged
- Evidence
- Transcript timestamp
- AI confidence

Actions:

- Confirm
- Dismiss
- Add Clinical Note

Use mock/local states.

---

# 21. FINAL CLINICAL REVIEW

Before sign-off, show a second-look summary such as:

- Clinical Risk
- Coding
- Evidence
- Documentation

Primary CTA:

**Review & Confirm**

---

# 22. TRANSCRIPT / AUDIO PLAYER

Create a professional transcript layout for:

- Doctor
- Patient
- Timestamps

Create a compact reusable audio player supporting UI states for:

- Play
- Pause
- Seek
- Jump to evidence timestamp

No real audio backend is required.

---

# 23. SUBSCRIPTION EXPERIENCE

Heading:

**Experience NourDoc**

Plans:

- FREE
- STARTER
- PROFESSIONAL
- ENTERPRISE

Do NOT invent real:

- prices
- usage limits
- features
- contract terms

Use clean placeholders where data is unavailable.

The subscription UI must remain visually part of the same NourDoc product.

Do not create a separate ecommerce-style visual language.

Do not mark any plan as "Best", "Most Popular", or "Recommended" unless explicitly present in the approved design.

---

# 24. PAYMENT UI

Supported visual options:

- Stripe
- JazzCash
- EasyPaisa
- Bank Transfer

UI flow:

**Select Plan → Select Payment Method → Payment/Transfer Instructions → Confirmation → Subscription Activated**

This phase is UI simulation only.

Do NOT integrate any real payment SDK.

Use mock states for:

- Payment pending
- Payment successful
- Payment failed

Do not invent bank account details.

---

# 25. PROFILE / SETTINGS

Profile should visually support:

- Doctor profile
- Professional information
- Current subscription
- Usage
- Payment methods
- Invoices
- Preferences
- Notifications
- Security
- Help
- Logout

Subscription status should remain visible and clear.

---

# 26. EMPTY STATES

Create consistent NourDoc empty-state components for at least:

- No patients
- No consultations
- No previous reports
- No processing reports
- No clinical risk signals
- No evidence
- No subscription
- No invoices
- No payment history

Use the organic/circuit illustration language.

Do not use random stock illustrations.

---

# 27. ERROR STATES

Provide polished UI states for:

- Generic error
- No connection
- Failed load
- Invalid form
- Payment failure
- Content unavailable

The UI must remain calm and professional.

---

# 28. NOTIFICATIONS

Support mock notification states for:

- Report Ready
- Processing Complete
- Clinical Review Required
- Risk Signal Detected
- Coding Review Required
- Subscription Activated
- Payment Successful
- Payment Pending
- Subscription Renewal
- Plan Limit Reached

Use:

- Icon
- Label/text
- Semantic color

Never communicate status using color alone.

---

# 29. MICRO-INTERACTIONS

Implement subtle animation only where it improves understanding.

Examples:

## Recording

Organic waveform / pulse responds visually.

## Processing

Circuit-tree or structured progress gradually activates.

## Report Ready

Smooth completion transition.

## Risk

Subtle attention treatment.

## Subscription

Smooth selected-plan state.

## Payment

Calm success/pending/failure state transition.

Avoid excessive animation.

Animations must not make the app feel playful or distracting.

---

# 30. ACCESSIBILITY

Prioritize:

- High contrast
- Clear typography
- Large touch targets
- Minimal cognitive load
- One-handed usability
- Consistent navigation
- Clear selected states
- Text/icon reinforcement for semantic status
- Good form labels
- Keyboard-safe forms

Where practical:

- Add semantic labels
- Support text scaling reasonably
- Avoid tiny touch targets
- Avoid text embedded inside raster images

---

# 31. ICONOGRAPHY

Use one consistent icon family unless Figma specifies otherwise.

Do not mix unrelated icon packs randomly.

Icons should be:

- clear
- clinical
- modern
- lightweight
- visually consistent

Match Figma sizing and stroke weight.

---

# 32. ASSET HANDLING

Before implementation:

1. Inspect available assets.
2. Reuse official NourDoc logo/assets.
3. Reuse Figma-exported SVG/PNG assets when supplied.
4. Do not replace branded visuals with random online graphics.
5. Keep asset paths organized.
6. Declare assets correctly in `pubspec.yaml`.
7. Verify every asset loads on a physical/emulated device.

Prefer SVG where appropriate for scalable brand illustrations.

---

# 33. MOCK DATA ARCHITECTURE

Create local typed mock models rather than placing huge inline maps inside widgets.

Examples:

```text
MockPatient
MockConsultation
MockReport
MockRiskSignal
MockCodingSuggestion
MockEvidence
MockNotification
MockSubscriptionPlan
MockInvoice
```

Keep the UI ready for future service/API replacement.

Do not prematurely build backend repositories/services unless needed solely to isolate mock data cleanly.

---

# 34. STATE MANAGEMENT

For this UI-only phase, use the simplest clean approach appropriate for a brand-new Flutter project.

Do not introduce a heavy state-management package solely for static screens.

Prefer Flutter-native local state unless a lightweight centralized approach becomes genuinely useful.

Local UI state is sufficient for things such as:

- selected tab
- selected filter
- selected care setting
- form state
- recording mock state
- processing progress
- plan selection
- payment mock status

Do not add Provider, Riverpod, Bloc, GetX, or another state-management dependency unless there is a clear UI-only need. Simplicity is preferred.

---

# 35. NAVIGATION

All primary screens must be reachable through working local navigation.

Verify:

- back navigation
- bottom navigation
- New Encounter flow
- patient profile flow
- report tabs
- subscription flow
- payment state flow
- settings routes

No dead buttons for primary navigational CTAs.

For backend-dependent actions, use mock transitions, local dialogs, snackbars, or static destination screens.

---

# 36. FORM BEHAVIOR

All forms should include proper UI states:

- default
- focused
- filled
- error
- disabled where relevant

Add basic local validation only for demonstrating UI behavior.

Do not create server-side validation.

---

# 37. QUALITY RULES

The code must be:

- readable
- modular
- reusable
- maintainable
- consistently named
- warning-free where reasonably possible
- formatted
- null-safe
- responsive

Avoid:

- giant 1,000+ line screen files
- repeated magic numbers
- deeply nested unreadable widget trees
- duplicate components
- unused code
- dead imports
- temporary debug widgets
- `print()` spam
- fake API code
- unrelated packages

Extract meaningful sections into private or shared widgets when it improves clarity.

---

# 38. REQUIRED IMPLEMENTATION PROCESS

Do NOT attempt to build all 52 screens blindly in one uncontrolled pass.

Follow this process.

## PHASE 1 — PROJECT BOOTSTRAP

Start from zero:

- [ ] Create a new Flutter project
- [ ] Confirm stable Flutter/Dart compatibility
- [ ] Configure `pubspec.yaml`
- [ ] Create the folder architecture
- [ ] Add Inter font / approved typography assets
- [ ] Add official NourDoc assets
- [ ] Configure SVG/image asset paths
- [ ] Establish routing/navigation
- [ ] Establish the global theme
- [ ] Create mock data/models
- [ ] Confirm backend/API integration is NOT part of this phase

Before mass screen implementation, briefly report what foundation was created.

---

## PHASE 2 — DESIGN FOUNDATION

Implement first:

- [ ] Colors
- [ ] Typography
- [ ] Spacing
- [ ] Radius
- [ ] Shadows
- [ ] Component dimensions
- [ ] Theme
- [ ] Asset helpers
- [ ] Core button styles
- [ ] Core input styles
- [ ] Core cards
- [ ] Navigation shell

Do not start mass screen development until the design foundation is coherent.

---

## PHASE 3 — CORE CLINICAL FLOW

Implement and validate:

- [ ] Clinical Workspace
- [ ] New Encounter
- [ ] Patient Selection
- [ ] Care Setting
- [ ] Intake
- [ ] Recording
- [ ] Processing
- [ ] Consultation
- [ ] Report

Use these screens to validate the design system before expanding.

---

## PHASE 4 — PATIENT / REPORT DETAIL

Implement:

- [ ] Patient Profile
- [ ] Timeline
- [ ] Previous Reports
- [ ] SOAP
- [ ] Coding
- [ ] Evidence
- [ ] Risk
- [ ] Transcript
- [ ] Final Review

---

## PHASE 5 — SUBSCRIPTION / ACCOUNT

Implement:

- [ ] Plans
- [ ] Plan Detail
- [ ] Compare Plans
- [ ] Upgrade
- [ ] Subscription Management
- [ ] Payment UI
- [ ] Invoice UI
- [ ] Profile
- [ ] Settings
- [ ] Security
- [ ] Notification Settings

---

## PHASE 6 — STATES / POLISH

Complete:

- [ ] Empty states
- [ ] Error states
- [ ] Loading states
- [ ] Disabled states
- [ ] Selected states
- [ ] Validation states
- [ ] Micro-interactions
- [ ] Responsive review
- [ ] Accessibility review

---

# 39. MANDATORY SCREEN-BY-SCREEN CHECKLIST

For EVERY screen you implement, verify:

```text
[ ] Figma structure matched
[ ] Correct background
[ ] Correct header
[ ] Correct typography hierarchy
[ ] Correct colors
[ ] Correct spacing
[ ] Correct card radius
[ ] Correct borders/shadows
[ ] Correct iconography
[ ] Correct CTA hierarchy
[ ] Correct bottom navigation behavior
[ ] Correct scroll behavior
[ ] SafeArea handled
[ ] Keyboard overlap handled where relevant
[ ] Small-screen overflow checked
[ ] Large-phone layout checked
[ ] Mock interaction works
[ ] No backend dependency introduced
[ ] Reusable widgets used where appropriate
[ ] No duplicated styling
[ ] No Flutter debug overflow
```

Do not mark a screen done until this checklist is satisfied.

---

# 40. MANDATORY FINAL CHECKLIST

Before reporting completion, run through this entire checklist.

## Project Health

- [ ] App builds successfully
- [ ] App launches successfully
- [ ] No fatal runtime errors
- [ ] No unresolved imports
- [ ] No missing assets
- [ ] No obvious analyzer errors caused by implementation
- [ ] Code formatted

## Design System

- [ ] Colors centralized
- [ ] Typography centralized
- [ ] Spacing centralized
- [ ] Radius centralized
- [ ] Shadows centralized
- [ ] Semantic status styling centralized
- [ ] Reusable buttons implemented
- [ ] Reusable inputs implemented
- [ ] Reusable cards implemented

## UI Consistency

- [ ] Figma is primary visual reference
- [ ] Deep Jade is used correctly
- [ ] No random colors
- [ ] No inconsistent card styles
- [ ] No inconsistent icon styles
- [ ] No inconsistent button heights
- [ ] No inconsistent input styles
- [ ] Clinical screens feel like one product
- [ ] Billing screens feel like the same product
- [ ] Subscription screens feel like the same product

## Responsiveness

- [ ] 375 × 812 checked
- [ ] 390 × 844 checked
- [ ] 393 × 852 checked
- [ ] 430 × 932 checked
- [ ] SafeArea checked
- [ ] No horizontal overflow
- [ ] No vertical render overflow
- [ ] Forms remain usable with keyboard
- [ ] Bottom CTAs remain reachable
- [ ] Long text does not break layouts

## Navigation

- [ ] Bottom navigation works
- [ ] New Encounter works
- [ ] Patient routes work
- [ ] Consultation routes work
- [ ] Report tabs work
- [ ] Subscription routes work
- [ ] Payment-state navigation works
- [ ] Settings routes work
- [ ] Back navigation works

## UI States

- [ ] Loading states
- [ ] Empty states
- [ ] Error states
- [ ] Selected states
- [ ] Disabled states
- [ ] Form validation states
- [ ] Processing states
- [ ] Recording states
- [ ] Payment states

## Scope Compliance

- [ ] No backend created
- [ ] No APIs integrated
- [ ] No database integrated
- [ ] No real payment SDK integrated
- [ ] No real audio/AI service integrated
- [ ] Mock/local data clearly separated
- [ ] Code remains ready for future API integration

## Accessibility

- [ ] Touch targets reasonable
- [ ] Important states do not rely only on color
- [ ] Text contrast acceptable
- [ ] Labels readable
- [ ] Main flows usable one-handed where possible

## Cleanup

- [ ] No unused imports
- [ ] No obsolete duplicate widgets
- [ ] No debug-only UI
- [ ] No temporary placeholder screens where final UI was required
- [ ] No TODO left for a screen being claimed as complete
- [ ] No unrelated files modified unnecessarily

---

# 41. VISUAL ACCEPTANCE CRITERIA

A screen is accepted only when:

1. A side-by-side comparison with Figma shows the same visual hierarchy.
2. Major spacing relationships match.
3. Colors match.
4. Typography matches.
5. Component proportions match.
6. Header/footer/nav alignment matches.
7. Cards and CTAs match.
8. No visible overflow exists.
9. It behaves correctly on the supported mobile sizes.
10. It looks intentional and premium, not like default Flutter Material widgets.

If a screen looks merely "similar" but visibly different from Figma, continue refining it.

---

# 42. DO NOT HIDE PROBLEMS

If something cannot be reproduced exactly because an asset or Figma detail is unavailable:

Do NOT silently invent it.

Instead report:

```text
VISUAL BLOCKER
Screen:
Element:
Missing reference:
Temporary implementation:
What is needed for exact match:
```

Continue with the best consistent implementation possible.

---

# 43. REQUIRED AGENT PROGRESS REPORT

After each meaningful implementation batch, output:

```text
IMPLEMENTATION PROGRESS

Completed:
- ...

Updated files:
- ...

Reusable components created:
- ...

Screens completed:
- ...

Responsive checks completed:
- ...

Known visual differences from Figma:
- ...

Remaining:
- ...
```

Keep this factual.

Do not claim work that has not been implemented.

---

# 44. REQUIRED FINAL REPORT

At the end, provide exactly these sections:

## 1. Implementation Summary

Briefly explain what was implemented.

## 2. Files Created / Updated

List important files.

## 3. Screens Completed

Show the 52-screen checklist with completed and incomplete items.

## 4. Reusable Components

List shared widgets/design-system components.

## 5. Responsive Validation

Report validation for:

- 375 × 812
- 390 × 844
- 393 × 852
- 430 × 932

## 6. UI States Tested

Report:

- loading
- empty
- error
- selected
- disabled
- recording
- processing
- payment

## 7. Backend Status

Explicitly confirm:

> No backend/API integration was implemented in this UI phase.

## 8. Known Differences / Blockers

List any differences from Figma.

## 9. Final Checklist

Reproduce the mandatory final checklist with real checked/unchecked status.

---

# 45. DEFINITION OF DONE

This UI task is complete only when:

- the Flutter project runs;
- the design system is reusable;
- required screens are implemented;
- primary navigation works;
- the New Encounter flow works using mock data;
- patient and consultation flows work locally;
- report sections work locally;
- subscription/payment screens work as UI simulations;
- supported mobile sizes have been checked;
- no obvious overflow remains;
- screens visually match Figma closely;
- no backend/API integration has been introduced;
- the completion checklist is truthfully filled.

---

# FINAL INSTRUCTION

Treat this as a **production-quality Figma-to-Flutter implementation**, not a prototype exercise.

Preserve NourDoc's approved clinical UX and visual identity.

**Do not redesign. Do not invent. Do not skip. Do not integrate backend.**

Build the complete new Flutter UI foundation from scratch now so that backend APIs can be integrated later without rebuilding the visual layer.

At every stage, prioritize:

**Figma fidelity → consistency → responsiveness → reusable components → clean code → future API readiness.**
