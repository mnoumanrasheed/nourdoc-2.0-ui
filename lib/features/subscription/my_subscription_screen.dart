import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/app_button.dart';
import '../../app/routes/app_routes.dart';

class MySubscriptionScreen extends StatelessWidget {
  const MySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('My Subscription', style: AppTypography.cardTitle),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 16,
          ),
          children: [
            // Current Plan Card
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Professional Plan',
                        style: AppTypography.cardTitle.copyWith(fontSize: 18, color: AppColors.deepJade),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.paleJade,
                          borderRadius: AppRadius.smBorder,
                        ),
                        child: Text(
                          'Active',
                          style: AppTypography.caption.copyWith(color: AppColors.deepJade, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text('\$99.00 / month', style: AppTypography.pageTitle.copyWith(fontSize: 24)),
                  const SizedBox(height: 8),
                  Text('Renews on November 01, 2026 via Visa •••• 4242', style: AppTypography.caption),
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 14),

                  // Quota indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Consultations this billing cycle', style: AppTypography.caption),
                      Text('42 / Unlimited', style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: const LinearProgressIndicator(
                      value: 0.42,
                      backgroundColor: AppColors.borderLight,
                      color: AppColors.deepJade,
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Subscription Quick Links
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppRadius.mdBorder,
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.credit_card_outlined, color: AppColors.deepJade),
                    title: Text('Payment Method', style: AppTypography.bodyMedium),
                    subtitle: Text('Visa ending in 4242', style: AppTypography.caption),
                    trailing: const Icon(Icons.chevron_right, size: 20),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.paymentMethod);
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.receipt_outlined, color: AppColors.deepJade),
                    title: Text('Billing & Invoices', style: AppTypography.bodyMedium),
                    subtitle: Text('Download tax receipts and history', style: AppTypography.caption),
                    trailing: const Icon(Icons.chevron_right, size: 20),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.invoiceHistory);
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.speed_outlined, color: AppColors.deepJade),
                    title: Text('Plan Usage Details', style: AppTypography.bodyMedium),
                    subtitle: Text('Encounter & storage allocation', style: AppTypography.caption),
                    trailing: const Icon(Icons.chevron_right, size: 20),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.usageLimits);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            AppButton(
              label: 'Change Plan',
              variant: ButtonVariant.outline,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.plans);
              },
            ),
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Subscription cancellation request submitted')),
                  );
                },
                child: Text('Cancel Subscription', style: AppTypography.metadata.copyWith(color: AppColors.rose)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

