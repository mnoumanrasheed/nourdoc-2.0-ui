import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../shared/widgets/app_button.dart';
import '../../app/routes/app_routes.dart';

class ClinicalContextScreen extends StatelessWidget {
  const ClinicalContextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final patient = MockData.patients.first;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Previous Clinical Context', style: AppTypography.cardTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.mdBorder,
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColors.paleJade,
                      child: Text(
                        patient.name.substring(0, 1),
                        style: AppTypography.cardTitle.copyWith(color: AppColors.deepJade),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(patient.name, style: AppTypography.cardTitle.copyWith(fontSize: 16)),
                          const SizedBox(height: 2),
                          Text('${patient.mrn} • ${patient.age}y ${patient.gender} • Follow-up Visit', style: AppTypography.metadata),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Text('Pre-Encounter Clinical Intelligence', style: AppTypography.sectionTitle.copyWith(fontSize: 16)),
              const SizedBox(height: 10),

              Expanded(
                child: ListView(
                  children: [
                    _buildContextItem(
                      icon: Icons.history_edu_outlined,
                      color: AppColors.deepJade,
                      title: 'Last Documented Encounter (Oct 02, 2026)',
                      body: 'Patient assessed for 10-day persistent dry cough. Prescribed OTC dextromethorphan and advised return if symptoms unresolved.',
                    ),
                    const SizedBox(height: 12),
                    _buildContextItem(
                      icon: Icons.warning_amber_rounded,
                      color: AppColors.rose,
                      title: 'Critical Allergy Alert',
                      body: 'Severe cutaneous reaction to Penicillin and Amoxicillin derivatives. Avoid beta-lactams.',
                    ),
                    const SizedBox(height: 12),
                    _buildContextItem(
                      icon: Icons.medication_liquid_outlined,
                      color: AppColors.clinicalBlue,
                      title: 'Active Regimen Reconciliation',
                      body: 'Lisinopril 10mg daily PO for primary hypertension. Note: Assess potential ACE inhibitor-induced cough.',
                    ),
                    const SizedBox(height: 12),
                    _buildContextItem(
                      icon: Icons.psychology_outlined,
                      color: AppColors.indigo,
                      title: 'Suggested Clinical Focus for AI',
                      body: 'Evaluate nocturnal coughing spells, reactive airway disease, and post-viral bronchial hyperresponsiveness.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),
              AppButton(
                label: 'Proceed to Ambient Recording',
                icon: Icons.mic_none_outlined,
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.recordingReady);
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContextItem({
    required IconData icon,
    required Color color,
    required String title,
    required String body,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.mdBorder,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: AppRadius.smBorder,
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.cardTitle.copyWith(fontSize: 14)),
                const SizedBox(height: 4),
                Text(body, style: AppTypography.body.copyWith(fontSize: 13, color: AppColors.slate)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

