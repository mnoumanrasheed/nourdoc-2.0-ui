import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/app_button.dart';
import '../../app/routes/app_routes.dart';

class BankTransferScreen extends StatelessWidget {
  const BankTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Bank Wire Instructions', style: AppTypography.cardTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Official Clinical Account Wire', style: AppTypography.sectionTitle),
              const SizedBox(height: 6),
              Text(
                'Transfer the subscription invoice amount to the official hospital corporate account.',
                style: AppTypography.body.copyWith(color: AppColors.slate),
              ),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.mdBorder,
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    _buildRow(context, 'Bank Name', 'Standard Chartered / Meezan Bank'),
                    const Divider(height: 16),
                    _buildRow(context, 'Account Title', 'NourDoc Technologies Pvt Ltd'),
                    const Divider(height: 16),
                    _buildRow(context, 'IBAN Number', 'PK36MEZN0001098200192801', canCopy: true),
                    const Divider(height: 16),
                    _buildRow(context, 'Invoice Reference', 'NOUR-INV-2026-901', canCopy: true),
                    const Divider(height: 16),
                    _buildRow(context, 'Amount Payable', 'PKR 27,500 / \$99.00 USD'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.clinicalMist,
                  borderRadius: AppRadius.smBorder,
                ),
                child: Text(
                  'Important: Always include your Invoice Reference in the transfer memo for automated receipt matching.',
                  style: AppTypography.caption.copyWith(color: AppColors.slate),
                ),
              ),

              const Spacer(),

              AppButton(
                label: 'I Have Completed the Wire Transfer',
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.paymentPending);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, String value, {bool canCopy = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTypography.caption.copyWith(color: AppColors.slate)),
        Row(
          children: [
            Text(value, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w700, fontSize: 13)),
            if (canCopy) ...[
              const SizedBox(width: 6),
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$label copied to clipboard')),
                  );
                },
                child: const Icon(Icons.copy, size: 14, color: AppColors.deepJade),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

