import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum CareSetting {
  emergency('Emergency', AppColors.emergency, Icons.emergency_outlined),
  opd('OPD', AppColors.opd, Icons.local_hospital_outlined),
  ipd('IPD', AppColors.ipd, Icons.hotel_outlined),
  ot('OT', AppColors.ot, Icons.medical_services_outlined);

  final String label;
  final Color color;
  final IconData icon;
  const CareSetting(this.label, this.color, this.icon);
}

enum VisitType {
  newVisit('New Visit'),
  followUp('Follow-up'),
  emergencyVisit('Emergency'),
  routineCheckup('Routine Checkup');

  final String label;
  const VisitType(this.label);
}

enum ConsultationStatus {
  ready('Ready for Review', AppColors.deepJade),
  processing('AI Processing', AppColors.warmAmber),
  delayed('Delayed', AppColors.rose),
  completed('Completed', AppColors.clinicalBlue);

  final String label;
  final Color color;
  const ConsultationStatus(this.label, this.color);
}

class MockVitals {
  final String temperature;
  final String pulse;
  final String respiration;
  final String bloodPressure;
  final String bloodSugar;

  const MockVitals({
    this.temperature = '98.6 °F',
    this.pulse = '76 bpm',
    this.respiration = '18 /min',
    this.bloodPressure = '120/80 mmHg',
    this.bloodSugar = '110 mg/dL',
  });
}

class MockPatient {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String phone;
  final String mrn;
  final String lastSeen;
  final int totalConsultations;
  final CareSetting careSetting;
  final MockVitals vitals;
  final String chiefComplaint;

  const MockPatient({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    required this.mrn,
    required this.lastSeen,
    required this.totalConsultations,
    required this.careSetting,
    required this.vitals,
    this.chiefComplaint = 'Persistent dry cough and shortness of breath for 5 days',
  });
}

class MockSoap {
  final String subjective;
  final String objective;
  final String assessment;
  final String plan;

  const MockSoap({
    required this.subjective,
    required this.objective,
    required this.assessment,
    required this.plan,
  });
}

class MockCoding {
  final String code;
  final String description;
  final String category; // 'ICD-10' or 'CPT'
  final bool isConfirmed;
  final double confidence;

  const MockCoding({
    required this.code,
    required this.description,
    required this.category,
    this.isConfirmed = false,
    this.confidence = 0.94,
  });
}

class MockEvidence {
  final String id;
  final String type; // 'Patient Evidence', 'External Reference', 'AI Interpretation'
  final String text;
  final String timestamp;
  final String speaker;

  const MockEvidence({
    required this.id,
    required this.type,
    required this.text,
    required this.timestamp,
    required this.speaker,
  });
}

class MockRiskSignal {
  final String id;
  final String title;
  final String severity; // 'Urgent Attention', 'Review Required', 'Advisory'
  final Color severityColor;
  final String description;
  final String whyFlagged;
  final String timestamp;
  final double confidence;
  final bool isConfirmed;

  const MockRiskSignal({
    required this.id,
    required this.title,
    required this.severity,
    required this.severityColor,
    required this.description,
    required this.whyFlagged,
    required this.timestamp,
    this.confidence = 0.92,
    this.isConfirmed = false,
  });
}

class MockConsultation {
  final String id;
  final String patientId;
  final String patientName;
  final int patientAge;
  final String patientGender;
  final VisitType visitType;
  final CareSetting careSetting;
  final String dateTime;
  final String duration;
  final ConsultationStatus status;
  final bool needsAttention;
  final String primaryDiagnosis;
  final MockSoap soap;
  final List<MockCoding> codings;
  final List<MockEvidence> evidenceList;
  final List<MockRiskSignal> riskSignals;

  const MockConsultation({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.patientAge,
    required this.patientGender,
    required this.visitType,
    required this.careSetting,
    required this.dateTime,
    required this.duration,
    required this.status,
    this.needsAttention = false,
    required this.primaryDiagnosis,
    required this.soap,
    required this.codings,
    required this.evidenceList,
    required this.riskSignals,
  });
}

class MockNotification {
  final String id;
  final String title;
  final String message;
  final String timeAgo;
  final IconData icon;
  final Color color;
  final bool isUnread;

  const MockNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.timeAgo,
    required this.icon,
    required this.color,
    this.isUnread = true,
  });
}

class MockSubscriptionPlan {
  final String id;
  final String name;
  final String price;
  final String billingPeriod;
  final String description;
  final bool isCurrent;
  final List<String> features;
  final String limits;

  const MockSubscriptionPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.billingPeriod,
    required this.description,
    this.isCurrent = false,
    required this.features,
    required this.limits,
  });
}

class MockInvoice {
  final String id;
  final String date;
  final String amount;
  final String status;
  final String method;

  const MockInvoice({
    required this.id,
    required this.date,
    required this.amount,
    required this.status,
    required this.method,
  });
}

