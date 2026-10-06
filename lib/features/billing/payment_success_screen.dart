import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/app_button.dart';
import '../../app/routes/app_routes.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

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
                'Subscription Activated',
                textAlign: TextAlign.center,
                style: AppTypography.pageTitle.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 10),
              Text(
                'Welcome to NourDoc Professional. Unlimited clinical encounter capture, intelligent SOAP documentation, and coding are now enabled for your workspace.',
                textAlign: TextAlign.center,
                style: AppTypography.body.copyWith(color: AppColors.slate),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.clinicalMist,
                  borderRadius: AppRadius.mdBorder,
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Plan', style: AppTypography.caption),
                        Text('Professional Tier', style: AppTypography.metadata.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Billing Amount', style: AppTypography.caption),
                        Text('\$99.00 USD / Month', style: AppTypography.metadata.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Receipt Number', style: AppTypography.caption),
                        Text('REC-892104-ND', style: AppTypography.metadata.copyWith(fontWeight: FontWeight.bold, color: AppColors.deepJade)),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              AppButton(
                label: 'Go to Clinical Workspace',
                icon: Icons.dashboard_outlined,
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.mainNav, (r) => false);
                },
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.invoiceHistory);
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(borderRadius: AppRadius.mdBorder),
                  side: const BorderSide(color: AppColors.border),
                ),
                child: const Text('View Invoice Details', style: TextStyle(color: AppColors.charcoal, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

