# NourDoc 2.0 Structure Migration Report

## Scope and safety

- Reference inspected: `C:\Users\mnoum\Downloads\M3hive data\NourDoc_Structure-main.zip`, extracted outside the project at `C:\Users\mnoum\AppData\Local\Temp\nourdoc_structure_reference`.
- Pre-migration source backup: `C:\Users\mnoum\AppData\Local\Temp\nourdoc_pre_structure_migration`.
- No Git commands that alter staging, history, branches, remotes, or GitHub were run. No commit or push was made.
- The current NourDoc 2.0 UI remains the implementation of record. No screen layout, route value, asset, theme value, mock-data value, or dependency was intentionally replaced.

## Architecture comparison

| Area | Before | After |
| --- | --- | --- |
| Application shell | `lib/app`, already containing app, routes, and navigation | Retained in place |
| Theme and assets | `lib/core/theme` and `lib/core/assets` | Retained in place |
| Shared UI components | `lib/shared/widgets` | `lib/core/widgets` |
| Shared demo domain data | `lib/models/mock` | `lib/core/models/mock` |
| Splash feature | `lib/features/auth/splash_screen.dart` | `lib/features/splash/splash_screen.dart` |
| Clinical UI features | Feature folders under `lib/features` | Retained in their existing domain folders |

The target now follows the reference's `app` / `core` / `features` separation without adding speculative empty backend folders. Existing plural `consultations` and `recording` directories were retained because they already contain the active UI and their names are used consistently by the app.

## Moved files

| Old path | New path |
| --- | --- |
| `lib/models/mock/mock_data.dart` | `lib/core/models/mock/mock_data.dart` |
| `lib/models/mock/mock_models.dart` | `lib/core/models/mock/mock_models.dart` |
| `lib/shared/widgets/app_audio_player.dart` | `lib/core/widgets/app_audio_player.dart` |
| `lib/shared/widgets/app_button.dart` | `lib/core/widgets/app_button.dart` |
| `lib/shared/widgets/app_text_field.dart` | `lib/core/widgets/app_text_field.dart` |
| `lib/shared/widgets/brand_logo.dart` | `lib/core/widgets/brand_logo.dart` |
| `lib/shared/widgets/clinical_badges.dart` | `lib/core/widgets/clinical_badges.dart` |
| `lib/shared/widgets/coding_card.dart` | `lib/core/widgets/coding_card.dart` |
| `lib/shared/widgets/encounter_card.dart` | `lib/core/widgets/encounter_card.dart` |
| `lib/shared/widgets/evidence_card.dart` | `lib/core/widgets/evidence_card.dart` |
| `lib/shared/widgets/metric_card.dart` | `lib/core/widgets/metric_card.dart` |
| `lib/shared/widgets/nourdoc_empty_state.dart` | `lib/core/widgets/nourdoc_empty_state.dart` |
| `lib/shared/widgets/nourdoc_error_state.dart` | `lib/core/widgets/nourdoc_error_state.dart` |
| `lib/shared/widgets/organic_waveform.dart` | `lib/core/widgets/organic_waveform.dart` |
| `lib/shared/widgets/patient_card.dart` | `lib/core/widgets/patient_card.dart` |
| `lib/shared/widgets/risk_card.dart` | `lib/core/widgets/risk_card.dart` |
| `lib/features/auth/splash_screen.dart` | `lib/features/splash/splash_screen.dart` |

## Created directories

- `lib/core/models/mock/`
- `lib/core/widgets/`
- `lib/features/splash/`

The former `lib/models/` and `lib/shared/` folders are empty local directories after the moves; empty folders are not source artifacts and do not affect Flutter compilation.

## Preserved implementation

- `lib/main.dart`, `lib/app/routes/app_routes.dart`, `lib/app/navigation/main_nav_shell.dart`, all active feature screens, platform projects, assets, `pubspec.yaml`, and tests were preserved as the NourDoc 2.0 implementation.
- Existing route values and navigation behavior were not changed. `NourDocApp` was updated only to import the moved splash screen and mock model.
- Existing mock classes and values were preserved; they are now explicitly isolated under `core/models/mock`.
- `dart format lib test` normalized Dart formatting across the project. This creates whitespace-only changes in files whose implementation did not otherwise change.

## Reference ZIP assessment

The reference project was fully inventoried across `app`, `core`, and `features`. Its organizational model was adopted, but none of its implementation files were copied because it is a separate `medicalai` application with an older UI, API assumptions, and dependencies not configured in this project.

| Reference components reviewed | Decision | Reason |
| --- | --- | --- |
| Routes, theme, core model, and widget folder organization | Adapted structurally | It cleanly separates application, shared core, and feature code. |
| Network API service, response status, exceptions, API logger, repository, app URLs | Deferred | No NourDoc 2.0 backend contract, endpoint configuration, authentication flow, or required dependencies exist. |
| Authentication, consultation, findings, profile, outbox ViewModels | Deferred | They are coupled to the reference repository and old screens; copying them would replace or break the current demo flows. |
| Hive storage, upload queue/database, upload sync service | Deferred | Requires persistence schema, migration plan, and background upload design. |
| Audio recorder implementation | Deferred | Requires recording permissions, platform configuration, and a product-approved recording/upload workflow. |
| PDF generation/export helpers | Deferred | Requires report-data contract and export requirements. |
| Subscription/entitlement and payment API services | Deferred | Current billing screens are UI-demo flows; no production payment or entitlement backend is configured. |

## Import updates

- Feature imports changed from `../../models/mock/...` to `../../core/models/mock/...`.
- Feature imports changed from `../../shared/widgets/...` to `../../core/widgets/...`.
- Moved core-widget files now use correct local `../theme`, `../assets`, and `../models/mock` imports.
- `lib/app/app.dart` now imports `core/models/mock/mock_models.dart` and `features/splash/splash_screen.dart`.
- A final source scan found no remaining imports of the former `lib/models/mock`, `lib/shared/widgets`, or `features/auth/splash_screen` paths.

## Validation

| Command | Result |
| --- | --- |
| `flutter pub get` | Passed; existing dependency set resolved. |
| `dart format lib test` | Passed; 80 Dart files processed. |
| `flutter analyze` | Passed with `No issues found!` |
| `flutter test` | Passed: 5 tests, including splash transition and all four responsive viewports. |

## Remaining issues and manual review

There are no known migration errors. Before making your own commit, review the local file moves and formatting diff, then run the app on the target device(s) to perform a visual smoke test of the existing clinical workflow. Backend integration should be designed separately before any deferred reference components are introduced.
