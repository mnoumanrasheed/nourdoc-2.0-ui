import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../models/mock/mock_models.dart';
import 'routes/app_routes.dart';
import 'navigation/main_nav_shell.dart';

// Auth
import '../features/auth/splash_screen.dart';
import '../features/auth/onboarding_screen.dart';
import '../features/auth/sign_in_screen.dart';
import '../features/auth/verification_screen.dart';
import '../features/auth/doctor_registration_screen.dart';

// Workspace & Patients
import '../features/workspace/workspace_screen.dart';
import '../features/workspace/notifications_screen.dart';
import '../features/patients/patient_search_screen.dart';
import '../features/patients/patient_profile_screen.dart';
import '../features/patients/patient_timeline_screen.dart';
import '../features/patients/previous_reports_screen.dart';

// Encounter Flow
import '../features/encounters/select_patient_screen.dart';
import '../features/encounters/care_setting_screen.dart';
import '../features/encounters/patient_intake_screen.dart';
import '../features/encounters/clinical_context_screen.dart';

// Recording & Processing
import '../features/recording/recording_ready_screen.dart';
import '../features/recording/recording_in_progress_screen.dart';
import '../features/recording/recording_paused_screen.dart';
import '../features/recording/consultation_submitted_screen.dart';
import '../features/processing/ai_processing_screen.dart';

// Consultations & Reports
import '../features/consultations/consultations_screen.dart';
import '../features/consultations/consultation_detail_screen.dart';
import '../features/reports/patient_report_overview_screen.dart';
import '../features/reports/patient_report_soap_screen.dart';
import '../features/reports/patient_report_coding_screen.dart';
import '../features/reports/patient_report_evidence_screen.dart';
import '../features/reports/evidence_transcript_mapping_screen.dart';
import '../features/clinical_risk/patient_report_risk_screen.dart';
import '../features/clinical_risk/risk_detail_screen.dart';
import '../features/reports/patient_report_transcript_screen.dart';
import '../features/reports/final_clinical_review_screen.dart';

// Subscription & Billing
import '../features/subscription/plans_screen.dart';
import '../features/subscription/plan_detail_screen.dart';
import '../features/subscription/compare_plans_screen.dart';
import '../features/subscription/upgrade_plan_screen.dart';
import '../features/subscription/my_subscription_screen.dart';
import '../features/billing/payment_method_screen.dart';
import '../features/billing/stripe_payment_screen.dart';
import '../features/billing/jazzcash_payment_screen.dart';
import '../features/billing/easypaisa_payment_screen.dart';
import '../features/billing/bank_transfer_screen.dart';
import '../features/billing/payment_pending_screen.dart';
import '../features/billing/payment_success_screen.dart';
import '../features/billing/payment_failed_screen.dart';
import '../features/billing/invoice_history_screen.dart';
import '../features/subscription/usage_limits_screen.dart';

// Account & States
import '../features/profile/profile_screen.dart';
import '../features/profile/settings_screen.dart';
import '../features/profile/notification_settings_screen.dart';
import '../features/profile/security_screen.dart';
import '../features/workspace/empty_states_screen.dart';
import '../features/workspace/error_states_screen.dart';

class NourDocApp extends StatelessWidget {
  const NourDocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NourDoc',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: (settings) {
        final args = settings.arguments;

        switch (settings.name) {
          case AppRoutes.splash:
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case AppRoutes.onboarding:
            return MaterialPageRoute(builder: (_) => const OnboardingScreen());
          case AppRoutes.signIn:
            return MaterialPageRoute(builder: (_) => const SignInScreen());
          case AppRoutes.verification:
            return MaterialPageRoute(builder: (_) => const VerificationScreen());
          case AppRoutes.doctorRegistration:
            return MaterialPageRoute(builder: (_) => const DoctorRegistrationScreen());
          case AppRoutes.mainNav:
            return MaterialPageRoute(builder: (_) => const MainNavShell());
          case AppRoutes.workspace:
            return MaterialPageRoute(builder: (_) => const WorkspaceScreen());
          case AppRoutes.notifications:
            return MaterialPageRoute(builder: (_) => const NotificationsScreen());
          case AppRoutes.patientSearch:
            return MaterialPageRoute(builder: (_) => const PatientSearchScreen());
          case AppRoutes.patientProfile:
            return MaterialPageRoute(
              builder: (_) => PatientProfileScreen(
                patient: args is MockPatient ? args : null,
              ),
            );
          case AppRoutes.patientTimeline:
            return MaterialPageRoute(
              builder: (_) => PatientTimelineScreen(
                patient: args is MockPatient ? args : null,
              ),
            );
          case AppRoutes.previousReports:
            return MaterialPageRoute(builder: (_) => const PreviousReportsScreen());
          case AppRoutes.selectPatient:
            return MaterialPageRoute(builder: (_) => const SelectPatientScreen());
          case AppRoutes.careSetting:
            return MaterialPageRoute(
              builder: (_) => CareSettingScreen(
                patient: args is MockPatient ? args : null,
              ),
            );
          case AppRoutes.patientIntake:
            return MaterialPageRoute(
              builder: (_) => PatientIntakeScreen(
                initialData: args is Map<String, dynamic> ? args : null,
              ),
            );
          case AppRoutes.clinicalContext:
            return MaterialPageRoute(builder: (_) => const ClinicalContextScreen());
          case AppRoutes.recordingReady:
            return MaterialPageRoute(builder: (_) => const RecordingReadyScreen());
          case AppRoutes.recordingInProgress:
            return MaterialPageRoute(builder: (_) => const RecordingInProgressScreen());
          case AppRoutes.recordingPaused:
            return MaterialPageRoute(builder: (_) => const RecordingPausedScreen());
          case AppRoutes.consultationSubmitted:
            return MaterialPageRoute(builder: (_) => const ConsultationSubmittedScreen());
          case AppRoutes.aiProcessing:
            return MaterialPageRoute(builder: (_) => const AiProcessingScreen());
          case AppRoutes.consultations:
            return MaterialPageRoute(builder: (_) => const ConsultationsScreen());
          case AppRoutes.consultationDetail:
            return MaterialPageRoute(
              builder: (_) => ConsultationDetailScreen(
                consultation: args is MockConsultation ? args : null,
              ),
            );
          case AppRoutes.reportOverview:
            return MaterialPageRoute(
              builder: (_) => PatientReportOverviewScreen(
                consultation: args is MockConsultation ? args : null,
              ),
            );
          case AppRoutes.reportSoap:
            return MaterialPageRoute(
              builder: (_) => PatientReportSoapScreen(
                consultation: args is MockConsultation ? args : null,
              ),
            );
          case AppRoutes.reportCoding:
            return MaterialPageRoute(
              builder: (_) => PatientReportCodingScreen(
                consultation: args is MockConsultation ? args : null,
              ),
            );
          case AppRoutes.reportEvidence:
            return MaterialPageRoute(
              builder: (_) => PatientReportEvidenceScreen(
                consultation: args is MockConsultation ? args : null,
              ),
            );
          case AppRoutes.evidenceTranscript:
            return MaterialPageRoute(
              builder: (_) => EvidenceTranscriptMappingScreen(arguments: args),
            );
          case AppRoutes.reportRisk:
            return MaterialPageRoute(
              builder: (_) => PatientReportRiskScreen(
                consultation: args is MockConsultation ? args : null,
              ),
            );
          case AppRoutes.riskDetail:
            return MaterialPageRoute(
              builder: (_) => RiskDetailScreen(
                signal: args is MockRiskSignal ? args : null,
              ),
            );
          case AppRoutes.reportTranscript:
            return MaterialPageRoute(
              builder: (_) => PatientReportTranscriptScreen(
                consultation: args is MockConsultation ? args : null,
              ),
            );
          case AppRoutes.finalClinicalReview:
            return MaterialPageRoute(
              builder: (_) => FinalClinicalReviewScreen(
                consultation: args is MockConsultation ? args : null,
              ),
            );
          case AppRoutes.plans:
            return MaterialPageRoute(builder: (_) => const PlansScreen());
          case AppRoutes.planDetail:
            return MaterialPageRoute(
              builder: (_) => PlanDetailScreen(
                plan: args is MockSubscriptionPlan ? args : null,
              ),
            );
          case AppRoutes.comparePlans:
            return MaterialPageRoute(builder: (_) => const ComparePlansScreen());
          case AppRoutes.upgradePlan:
            return MaterialPageRoute(builder: (_) => const UpgradePlanScreen());
          case AppRoutes.mySubscription:
            return MaterialPageRoute(builder: (_) => const MySubscriptionScreen());
          case AppRoutes.paymentMethod:
            return MaterialPageRoute(
              builder: (_) => PaymentMethodScreen(plan: args),
            );
          case AppRoutes.stripePayment:
            return MaterialPageRoute(builder: (_) => const StripePaymentScreen());
          case AppRoutes.jazzCashPayment:
            return MaterialPageRoute(builder: (_) => const JazzCashPaymentScreen());
          case AppRoutes.easyPaisaPayment:
            return MaterialPageRoute(builder: (_) => const EasyPaisaPaymentScreen());
          case AppRoutes.bankTransfer:
            return MaterialPageRoute(builder: (_) => const BankTransferScreen());
          case AppRoutes.paymentPending:
            return MaterialPageRoute(builder: (_) => const PaymentPendingScreen());
          case AppRoutes.paymentSuccess:
            return MaterialPageRoute(builder: (_) => const PaymentSuccessScreen());
          case AppRoutes.paymentFailed:
            return MaterialPageRoute(builder: (_) => const PaymentFailedScreen());
          case AppRoutes.invoiceHistory:
            return MaterialPageRoute(builder: (_) => const InvoiceHistoryScreen());
          case AppRoutes.usageLimits:
            return MaterialPageRoute(builder: (_) => const UsageLimitsScreen());
          case AppRoutes.profile:
            return MaterialPageRoute(builder: (_) => const ProfileScreen());
          case AppRoutes.settings:
            return MaterialPageRoute(builder: (_) => const SettingsScreen());
          case AppRoutes.notificationSettings:
            return MaterialPageRoute(builder: (_) => const NotificationSettingsScreen());
          case AppRoutes.security:
            return MaterialPageRoute(builder: (_) => const SecurityScreen());
          case AppRoutes.emptyStatesShowcase:
            return MaterialPageRoute(builder: (_) => const EmptyStatesScreen());
          case AppRoutes.errorStatesShowcase:
            return MaterialPageRoute(builder: (_) => const ErrorStatesScreen());
          default:
            return MaterialPageRoute(builder: (_) => const MainNavShell());
        }
      },
    );
  }
}

