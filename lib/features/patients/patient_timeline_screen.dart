import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../models/mock/mock_models.dart';

class PatientTimelineScreen extends StatelessWidget {
  final MockPatient? patient;

  const PatientTimelineScreen({super.key, this.patient});

  @override
  Widget build(BuildContext context) {
    final p = patient ?? MockData.patients.first;

    final events = [
      {
        'date': 'Today, 10:30 AM',
        'title': 'Outpatient Clinical Encounter (OPD)',
        'description': 'Assessment for post-viral bronchitis and reactive airway disease. Inhaler prescribed.',
        'doctor': 'Dr. Nouman, MD',
        'type': 'Consultation',
      },
      {
        'date': 'Oct 02, 2026, 09:15 AM',
        'title': 'Comprehensive Metabolic & CBC Panel',
        'description': 'Normal kidney function, normal liver transaminases. WBC 7.2 k/uL.',
        'doctor': 'Central Pathology Lab',
        'type': 'Laboratory',
      },
      {
        'date': 'Sep 25, 2026, 04:00 PM',
        'title': 'Pharmacy Medication Dispensation',
        'description': 'Dispensed Lisinopril 10mg #90 tabs with 3 refills authorized.',
        'doctor': 'Hospital Pharmacy',
        'type': 'Pharmacy',
      },
      {
        'date': 'Aug 14, 2026, 11:00 AM',
        'title': 'Annual Physical Examination & Baseline ECG',
        'description': 'Sinus rhythm, no ischemic ST changes. Blood pressure recorded at 130/84 mmHg.',
        'doctor': 'Dr. Nouman, MD',
        'type': 'Consultation',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Longitudinal Timeline: ${p.name}', style: AppTypography.cardTitle),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 20,
          ),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final ev = events[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: AppColors.deepJade,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                    if (index < events.length - 1)
                      Container(
                        width: 2,
                        height: 90,
                        color: AppColors.border,
                      ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ev['type']!,
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.deepJade,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                ev['date']!,
                                style: AppTypography.caption.copyWith(color: AppColors.slate),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(ev['title']!, style: AppTypography.cardTitle.copyWith(fontSize: 14)),
                          const SizedBox(height: 4),
                          Text(ev['description']!, style: AppTypography.body.copyWith(fontSize: 13)),
                          const SizedBox(height: 8),
                          Text('Provider: ${ev['doctor']}', style: AppTypography.caption.copyWith(fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

