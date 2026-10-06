import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../models/mock/mock_models.dart';
import '../../shared/widgets/app_button.dart';
import '../../app/routes/app_routes.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = MockData.plans;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Experience NourDoc', style: AppTypography.cardTitle),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.comparePlans);
            },
            child: Text(
              'Compare',
              style: AppTypography.metadata.copyWith(
                color: AppColors.deepJade,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 16,
          ),
          children: [
            Text(
              'Experience NourDoc',
              style: AppTypography.pageTitle.copyWith(fontSize: 24),
            ),
            const SizedBox(height: 6),
            Text(
              'Empower your clinical practice with scalable AI documentation and verified coding workflows.',
              style: AppTypography.body.copyWith(color: AppColors.slate),
            ),
            const SizedBox(height: 20),

            ...plans.map((plan) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildPlanCard(context, plan),
                )),

            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.usageLimits);
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(borderRadius: AppRadius.mdBorder),
                side: const BorderSide(color: AppColors.border),
              ),
              child: Text(
                'View Current Usage & Encounter Limits',
                style: AppTypography.bodyMedium.copyWith(color: AppColors.charcoal),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, MockSubscriptionPlan plan) {
    final isCurrent = plan.isCurrent;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.mdBorder,
        border: Border.all(
          color: isCurrent ? AppColors.deepJade : AppColors.border,
          width: isCurrent ? 2.0 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                plan.name,
                style: AppTypography.cardTitle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: isCurrent ? AppColors.deepJade : AppColors.charcoal,
                ),
              ),
              if (isCurrent)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.paleJade,
                    borderRadius: AppRadius.smBorder,
                  ),
                  child: Text(
                    'Active Plan',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.deepJade,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                plan.price,
                style: AppTypography.pageTitle.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: AppColors.charcoal,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                plan.billingPeriod,
                style: AppTypography.caption.copyWith(color: AppColors.slate),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            plan.description,
            style: AppTypography.body.copyWith(fontSize: 13, color: AppColors.slate),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 14),

          ...plan.features.map(
            (feat) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_rounded, size: 16, color: AppColors.deepJade),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      feat,
                      style: AppTypography.body.copyWith(fontSize: 13, color: AppColors.charcoal),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          AppButton(
            label: isCurrent ? 'Manage Subscription' : (plan.id == 'plan_enterprise' ? 'Contact Sales' : 'Select ${plan.name}'),
            variant: isCurrent ? ButtonVariant.outline : ButtonVariant.primary,
            onPressed: () {
              if (isCurrent) {
                Navigator.of(context).pushNamed(AppRoutes.mySubscription);
              } else {
                Navigator.of(context).pushNamed(AppRoutes.planDetail, arguments: plan);
              }
            },
          ),
        ],
      ),
    );
  }
}

