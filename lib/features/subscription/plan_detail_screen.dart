import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../models/mock/mock_models.dart';
import '../../shared/widgets/app_button.dart';
import '../../app/routes/app_routes.dart';

class PlanDetailScreen extends StatelessWidget {
  final MockSubscriptionPlan? plan;

  const PlanDetailScreen({super.key, this.plan});

  @override
  Widget build(BuildContext context) {
    final p = plan ?? MockData.plans[2]; // Pro

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('${p.name} Plan', style: AppTypography.cardTitle),
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
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppRadius.mdBorder,
                        border: Border.all(color: AppColors.deepJade, width: 1.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p.name, style: AppTypography.pageTitle.copyWith(fontSize: 22, color: AppColors.deepJade)),
                          const SizedBox(height: 6),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(p.price, style: AppTypography.pageTitle.copyWith(fontSize: 34)),
                              const SizedBox(width: 6),
                              Text(p.billingPeriod, style: AppTypography.caption),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(p.description, style: AppTypography.body.copyWith(color: AppColors.slate)),
                          const SizedBox(height: 20),
                          Text('Included Clinical Capabilities:', style: AppTypography.cardTitle.copyWith(fontSize: 14)),
                          const SizedBox(height: 12),
                          ...p.features.map(
                            (f) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  const Icon(Icons.check_circle_outline, size: 18, color: AppColors.deepJade),
                                  const SizedBox(width: 10),
                                  Expanded(child: Text(f, style: AppTypography.body.copyWith(fontSize: 13.5))),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.clinicalMist,
                              borderRadius: AppRadius.smBorder,
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.speed_outlined, size: 16, color: AppColors.slate),
                                const SizedBox(width: 8),
                                Text('Quota: ${p.limits}', style: AppTypography.caption.copyWith(fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppRadius.mdBorder,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.shield_outlined, color: AppColors.deepJade, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Cancel anytime with no lock-in contract. Clinical records remain exported and accessible.',
                              style: AppTypography.caption,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              AppButton(
                label: 'Proceed to Payment Method',
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.paymentMethod, arguments: p);
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

