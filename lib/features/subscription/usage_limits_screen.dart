import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/app_button.dart';
import '../../app/routes/app_routes.dart';

class UsageLimitsScreen extends StatelessWidget {
  const UsageLimitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Plan Usage & Limits', style: AppTypography.cardTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 16,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Text('Workspace Resource Consumption', style: AppTypography.sectionTitle),
                    const SizedBox(height: 6),
                    Text(
                      'Track ambient listening minutes, clinical storage, and ICD coding utilization.',
                      style: AppTypography.caption,
                    ),
                    const SizedBox(height: 20),

                    _buildUsageBar(
                      title: 'Monthly Encounters Processed',
                      current: '42 Encounters',
                      limit: 'Unlimited (Pro)',
                      progress: 0.35,
                      color: AppColors.deepJade,
                    ),
                    const SizedBox(height: 16),

                    _buildUsageBar(
                      title: 'Audio Cloud Storage',
                      current: '3.4 GB',
                      limit: '50.0 GB',
                      progress: 0.07,
                      color: AppColors.clinicalBlue,
                    ),
                    const SizedBox(height: 16),

                    _buildUsageBar(
                      title: 'AI Clinical Risk Evaluations',
                      current: '118 Evaluations',
                      limit: 'Unlimited (Pro)',
                      progress: 0.40,
                      color: AppColors.warmAmber,
                    ),
                    const SizedBox(height: 16),

                    _buildUsageBar(
                      title: 'EHR Export Integrations',
                      current: '8 Exports',
                      limit: 'Unlimited (Pro)',
                      progress: 0.15,
                      color: AppColors.indigo,
                    ),
                    const SizedBox(height: 24),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppRadius.mdBorder,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle_outline, color: AppColors.deepJade, size: 22),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Your workspace is running well within safe clinical operating capacity.',
                              style: AppTypography.caption.copyWith(color: AppColors.charcoal, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              AppButton(
                label: 'Manage Subscription Tier',
                variant: ButtonVariant.outline,
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.mySubscription);
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsageBar({
    required String title,
    required String current,
    required String limit,
    required double progress,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.mdBorder,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTypography.cardTitle.copyWith(fontSize: 14)),
              Text(current, style: AppTypography.metadata.copyWith(fontWeight: FontWeight.bold, color: color)),
            ],
          ),
          const SizedBox(height: 4),
          Text('Limit: $limit', style: AppTypography.caption),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.clinicalMist,
              color: color,
              minHeight: 7,
            ),
          ),
        ],
      ),
    );
  }
}

