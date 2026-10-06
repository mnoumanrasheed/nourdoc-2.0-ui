import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../models/mock/mock_models.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/clinical_badges.dart';
import '../../app/routes/app_routes.dart';

class RecordingPausedScreen extends StatelessWidget {
  const RecordingPausedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final patient = MockData.patients.first;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Clinical Encounter', style: AppTypography.cardTitle),
        automaticallyImplyLeading: false,
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
              const SizedBox(height: 24),

              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: AppColors.amberLight,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.warmAmber.withOpacity(0.4), width: 2),
                ),
                child: const Icon(Icons.pause, size: 44, color: AppColors.warmAmber),
              ),
              const SizedBox(height: 24),

              Text(
                'Recording Paused',
                style: AppTypography.pageTitle.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 8),
              Text(
                '03:42 captured so far',
                style: AppTypography.cardTitle.copyWith(
                  color: AppColors.slate,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Audio listening is paused. You can resume at any time or finalize the consultation.',
                textAlign: TextAlign.center,
                style: AppTypography.body.copyWith(color: AppColors.slate),
              ),

              const SizedBox(height: 32),

              AppButton(
                label: 'Resume Recording',
                icon: Icons.play_arrow,
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.recordingInProgress);
                },
              ),
              const SizedBox(height: 12),
              AppButton(
                label: 'Finish Consultation',
                variant: ButtonVariant.secondary,
                icon: Icons.check_circle_outline,
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.consultationSubmitted);
                },
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.mainNav, (r) => false);
                },
                child: Text('Discard Encounter', style: AppTypography.metadata.copyWith(color: AppColors.rose)),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

