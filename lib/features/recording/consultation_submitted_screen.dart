import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../shared/widgets/app_button.dart';
import '../../app/routes/app_routes.dart';

class ConsultationSubmittedScreen extends StatelessWidget {
  const ConsultationSubmittedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final patient = MockData.patients.first;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.mainNav, (r) => false);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppColors.paleJade,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.deepJade.withOpacity(0.3), width: 2),
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  size: 52,
                  color: AppColors.deepJade,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'Encounter Audio Captured',
                textAlign: TextAlign.center,
                style: AppTypography.pageTitle.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 10),
              Text(
                '11m 45s of clinical consultation dialogue recorded for ${patient.name}. The audio is securely queued for intelligent medical structuring.',
                textAlign: TextAlign.center,
                style: AppTypography.body.copyWith(color: AppColors.slate),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.clinicalMist,
                  borderRadius: AppRadius.mdBorder,
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Encounter Reference', style: AppTypography.metadata),
                    Text(
                      'ENC-2026-891',
                      style: AppTypography.metadata.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.deepJade,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              AppButton(
                label: 'View AI Processing',
                icon: Icons.auto_awesome,
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.aiProcessing);
                },
              ),
              const SizedBox(height: 12),
              AppButton(
                label: 'Back to Workspace',
                variant: ButtonVariant.secondary,
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.mainNav, (r) => false);
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

