import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nourdoc/app/app.dart';
import 'package:nourdoc/app/navigation/main_nav_shell.dart';
import 'package:nourdoc/features/auth/onboarding_screen.dart';
import 'package:nourdoc/features/auth/sign_in_screen.dart';
import 'package:nourdoc/features/encounters/care_setting_screen.dart';
import 'package:nourdoc/features/encounters/clinical_context_screen.dart';
import 'package:nourdoc/features/encounters/patient_intake_screen.dart';
import 'package:nourdoc/features/encounters/select_patient_screen.dart';
import 'package:nourdoc/features/recording/recording_ready_screen.dart';
import 'package:nourdoc/features/recording/recording_in_progress_screen.dart';
import 'package:nourdoc/features/recording/recording_paused_screen.dart';
import 'package:nourdoc/features/processing/ai_processing_screen.dart';
import 'package:nourdoc/features/reports/patient_report_overview_screen.dart';
import 'package:nourdoc/features/reports/patient_report_soap_screen.dart';
import 'package:nourdoc/features/reports/patient_report_coding_screen.dart';
import 'package:nourdoc/features/consultations/consultation_detail_screen.dart';
import 'package:nourdoc/features/subscription/plans_screen.dart';
import 'package:nourdoc/features/billing/payment_method_screen.dart';
import 'package:nourdoc/features/profile/settings_screen.dart';
import 'package:nourdoc/features/workspace/empty_states_screen.dart';

void main() {
  testWidgets('NourDoc app smoke test and splash transition', (WidgetTester tester) async {
    await tester.pumpWidget(const NourDocApp());
    expect(find.text('INTELLIGENT CLINICAL WORKSPACE'), findsOneWidget);

    // Fast-forward splash screen timer into Onboarding
    await tester.pump(const Duration(milliseconds: 2500));
    await tester.pumpAndSettle();
    expect(find.text('Intelligent Clinical Listening'), findsOneWidget);
  });

  const testViewports = [
    Size(375, 812), // iPhone mini / SE
    Size(390, 844), // iPhone 12/13/14 Figma baseline
    Size(393, 852), // iPhone 15/16
    Size(430, 932), // iPhone 15/16 Pro Max
  ];

  for (final size in testViewports) {
    testWidgets('Responsive & Overflow Validation on ${size.width.toInt()}x${size.height.toInt()}', (WidgetTester tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      // 1. Validate Main Workspace & Nav Shell
      await tester.pumpWidget(const MaterialApp(home: MainNavShell()));
      await tester.pumpAndSettle();
      expect(find.text('CLINICAL WORKSPACE'), findsOneWidget);
      expect(find.text('Good morning, Dr. Ahmed'), findsOneWidget);
      expect(find.text('NEEDS ATTENTION'), findsOneWidget);
      expect(find.text("TODAY'S ENCOUNTERS"), findsOneWidget);

      // Verify bottom navigation tabs
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Schedule'), findsOneWidget);
      expect(find.text('Encounter'), findsOneWidget);
      expect(find.text('Patients'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);

      // 2. Validate Auth Screens
      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
      await tester.pumpAndSettle();
      expect(find.text('Sign In to Workspace'), findsOneWidget);

      await tester.pumpWidget(const MaterialApp(home: SignInScreen()));
      await tester.pumpAndSettle();
      expect(find.text('Welcome Back, Doctor'), findsOneWidget);

      // 3. Validate Encounter Flow
      await tester.pumpWidget(const MaterialApp(home: SelectPatientScreen()));
      await tester.pumpAndSettle();
      expect(find.textContaining('Select Patient'), findsOneWidget);

      await tester.pumpWidget(const MaterialApp(home: CareSettingScreen()));
      await tester.pumpAndSettle();
      expect(find.text('Where is this patient being seen?'), findsOneWidget);

      await tester.pumpWidget(const MaterialApp(home: PatientIntakeScreen()));
      await tester.pumpAndSettle();
      expect(find.text('Clinical Intake & Vitals'), findsOneWidget);

      await tester.pumpWidget(const MaterialApp(home: ClinicalContextScreen()));
      await tester.pumpAndSettle();
      expect(find.text('Previous Clinical Context'), findsOneWidget);

      // 4. Validate Recording & Review
      await tester.pumpWidget(const MaterialApp(home: RecordingReadyScreen()));
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Ready to Record Encounter'), findsOneWidget);

      await tester.pumpWidget(const MaterialApp(home: RecordingInProgressScreen()));
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Clinical Encounter'), findsOneWidget);

      await tester.pumpWidget(const MaterialApp(home: RecordingPausedScreen()));
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Recording Paused'), findsOneWidget);

      // 5. Validate AI Processing
      await tester.pumpWidget(const MaterialApp(home: AiProcessingScreen()));
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Clinical Intelligence Engine'), findsOneWidget);

      // 6. Validate Clinical Documentation
      await tester.pumpWidget(const MaterialApp(home: PatientReportOverviewScreen()));
      await tester.pumpAndSettle();
      expect(find.text('Clinical Report'), findsOneWidget);

      await tester.pumpWidget(const MaterialApp(home: PatientReportSoapScreen()));
      await tester.pumpAndSettle();
      expect(find.text('SOAP Note Documentation'), findsOneWidget);

      await tester.pumpWidget(const MaterialApp(home: PatientReportCodingScreen()));
      await tester.pumpAndSettle();
      expect(find.text('Medical Coding (ICD-10 & CPT)'), findsOneWidget);

      await tester.pumpWidget(const MaterialApp(home: ConsultationDetailScreen()));
      await tester.pumpAndSettle();
      expect(find.text('Consultation Summary'), findsOneWidget);

      // 7. Validate Subscription & Billing
      await tester.pumpWidget(const MaterialApp(home: PlansScreen()));
      await tester.pumpAndSettle();
      expect(find.text('Experience NourDoc'), findsWidgets);

      await tester.pumpWidget(const MaterialApp(home: PaymentMethodScreen()));
      await tester.pumpAndSettle();
      expect(find.text('Payment Method'), findsOneWidget);

      // 8. Validate Settings & States
      await tester.pumpWidget(const MaterialApp(home: SettingsScreen()));
      await tester.pumpAndSettle();
      expect(find.text('Settings & Preferences'), findsOneWidget);

      await tester.pumpWidget(const MaterialApp(home: EmptyStatesScreen()));
      await tester.pumpAndSettle();
      expect(find.text('Empty States Showcase'), findsOneWidget);
    });
  }
}
