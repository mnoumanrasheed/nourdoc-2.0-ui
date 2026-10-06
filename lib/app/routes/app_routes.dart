class AppRoutes {
  AppRoutes._();

  // Auth
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String signIn = '/sign-in';
  static const String verification = '/verification';
  static const String doctorRegistration = '/doctor-registration';

  // Navigation Shell
  static const String mainNav = '/main-nav';

  // Workspace & Patients
  static const String workspace = '/workspace';
  static const String notifications = '/notifications';
  static const String patientSearch = '/patient-search';
  static const String patientProfile = '/patient-profile';
  static const String patientTimeline = '/patient-timeline';
  static const String previousReports = '/previous-reports';

  // Encounter Flow
  static const String selectPatient = '/select-patient';
  static const String careSetting = '/care-setting';
  static const String patientIntake = '/patient-intake';
  static const String clinicalContext = '/clinical-context';

  // Recording & AI Processing
  static const String recordingReady = '/recording-ready';
  static const String recordingInProgress = '/recording-in-progress';
  static const String recordingPaused = '/recording-paused';
  static const String consultationSubmitted = '/consultation-submitted';
  static const String aiProcessing = '/ai-processing';

  // Consultations & Reports
  static const String consultations = '/consultations';
  static const String consultationDetail = '/consultation-detail';
  static const String reportOverview = '/report-overview';
  static const String reportSoap = '/report-soap';
  static const String reportCoding = '/report-coding';
  static const String reportEvidence = '/report-evidence';
  static const String evidenceTranscript = '/evidence-transcript';
  static const String reportRisk = '/report-risk';
  static const String riskDetail = '/risk-detail';
  static const String reportTranscript = '/report-transcript';
  static const String finalClinicalReview = '/final-clinical-review';

  // Subscription & Billing
  static const String plans = '/plans';
  static const String planDetail = '/plan-detail';
  static const String comparePlans = '/compare-plans';
  static const String upgradePlan = '/upgrade-plan';
  static const String mySubscription = '/my-subscription';
  static const String paymentMethod = '/payment-method';
  static const String stripePayment = '/stripe-payment';
  static const String jazzCashPayment = '/jazzcash-payment';
  static const String easyPaisaPayment = '/easypaisa-payment';
  static const String bankTransfer = '/bank-transfer';
  static const String paymentPending = '/payment-pending';
  static const String paymentSuccess = '/payment-success';
  static const String paymentFailed = '/payment-failed';
  static const String invoiceHistory = '/invoice-history';
  static const String usageLimits = '/usage-limits';

  // Account
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String notificationSettings = '/notification-settings';
  static const String security = '/security';
  static const String emptyStatesShowcase = '/empty-states-showcase';
  static const String errorStatesShowcase = '/error-states-showcase';
}

