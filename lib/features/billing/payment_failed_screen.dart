import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/app_button.dart';
import '../../app/routes/app_routes.dart';

class PaymentFailedScreen extends StatelessWidget {
  const PaymentFailedScreen({super.key});

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
                  color: AppColors.roseLight,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.rose.withOpacity(0.4), width: 2),
                ),
                child: const Icon(
                  Icons.error_outline_rounded,
                  size: 50,
                  color: AppColors.rose,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'Payment Transaction Failed',
                textAlign: TextAlign.center,
                style: AppTypography.pageTitle.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 10),
              Text(
                'The issuing bank or wallet declined the charge (Error: Insufficient clinical limit or 3DS verification timeout). No funds were deducted.',
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
                  children: [
                    const Icon(Icons.help_outline, color: AppColors.slate, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'You may retry with an alternative card or select JazzCash / EasyPaisa / Bank Wire.',
                        style: AppTypography.caption,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              AppButton(
                label: 'Retry Payment',
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.paymentMethod);
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

