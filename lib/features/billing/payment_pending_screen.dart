import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/app_button.dart';
import '../../app/routes/app_routes.dart';

class PaymentPendingScreen extends StatelessWidget {
  const PaymentPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: AppColors.amberLight,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.warmAmber.withOpacity(0.4), width: 2),
                ),
                child: const Icon(
                  Icons.hourglass_top_rounded,
                  size: 46,
                  color: AppColors.warmAmber,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'Payment Verification Pending',
                textAlign: TextAlign.center,
                style: AppTypography.pageTitle.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 10),
              Text(
                'Your payment request is being reconciled with the billing gateway. You will receive an alert once your Professional tier is fully activated.',
                textAlign: TextAlign.center,
                style: AppTypography.body.copyWith(color: AppColors.slate),
              ),
              const SizedBox(height: 24),
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
                    Text('Estimated Approval Time', style: AppTypography.caption),
                    Text('15 – 30 Minutes', style: AppTypography.metadata.copyWith(fontWeight: FontWeight.bold, color: AppColors.warmAmber)),
                  ],
                ),
              ),
              const Spacer(),
              AppButton(
                label: 'Simulate Approval (Instant Success)',
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.paymentSuccess);
                },
              ),
              const SizedBox(height: 12),
              AppButton(
                label: 'Return to Workspace',
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

