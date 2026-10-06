import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../models/mock/mock_models.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/clinical_badges.dart';
import '../../shared/widgets/organic_waveform.dart';
import '../../app/routes/app_routes.dart';

class RecordingReadyScreen extends StatelessWidget {
  const RecordingReadyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final patient = MockData.patients.first;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Clinical Encounter', style: AppTypography.cardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 16,
          ),
          child: Column(
            children: [
              // Patient Banner
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.clinicalMist,
                  borderRadius: AppRadius.mdBorder,
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            patient.name,
                            style: AppTypography.cardTitle.copyWith(fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${patient.age}y ${patient.gender} • Follow-up Visit',
                            style: AppTypography.caption,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    CareSettingBadge(setting: CareSetting.opd, compact: true),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Signature NourDoc Audio Visual Motif
              const OrganicWaveform(isRecording: false, size: 175),
              const SizedBox(height: 24),

              Text(
                'Ready to Record Encounter',
                style: AppTypography.pageTitle.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 8),
              Text(
                'Place your device between you and the patient. NourDoc will ambiently capture the clinical dialogue.',
                textAlign: TextAlign.center,
                style: AppTypography.body.copyWith(color: AppColors.slate),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.paleJade,
                  borderRadius: AppRadius.smBorder,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.lock_outline, size: 14, color: AppColors.deepJade),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        'HIPAA & Clinical Confidentiality Active',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.deepJade,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              AppButton(
                label: 'Start Recording Encounter',
                icon: Icons.fiber_manual_record,
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.recordingInProgress);
                },
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.of(context).maybePop(),
                child: Text('Cancel Encounter', style: AppTypography.metadata.copyWith(color: AppColors.slate)),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

