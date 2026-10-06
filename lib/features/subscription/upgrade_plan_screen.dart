import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../shared/widgets/app_button.dart';
import '../../app/routes/app_routes.dart';

class UpgradePlanScreen extends StatefulWidget {
  const UpgradePlanScreen({super.key});

  @override
  State<UpgradePlanScreen> createState() => _UpgradePlanScreenState();
}

class _UpgradePlanScreenState extends State<UpgradePlanScreen> {
  String _selectedBilling = 'Annual (Save 20%)';

  @override
  Widget build(BuildContext context) {
    final proPlan = MockData.plans[2];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Upgrade Workspace', style: AppTypography.cardTitle),
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
                    // Promotion Header
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.deepJade, AppColors.freshJade],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: AppRadius.mdBorder,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: AppRadius.smBorder,
                            ),
                            child: Text(
                              'CLINICAL INTELLIGENCE UPGRADE',
                              style: AppTypography.caption.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Professional Plan',
                            style: AppTypography.pageTitle.copyWith(color: Colors.white, fontSize: 24),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Unlimited ambient encounters, real-time ICD-10/CPT coding, and traceable clinical risk signals.',
                            style: AppTypography.body.copyWith(color: Colors.white.withOpacity(0.9), fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Billing Cycle Toggle
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppRadius.mdBorder,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: ['Monthly (\$99/mo)', 'Annual (Save 20%)'].map((opt) {
                          final isSel = _selectedBilling == opt;
                          return Expanded(
                            child: InkWell(
                              onTap: () => setState(() => _selectedBilling = opt),
                              borderRadius: AppRadius.smBorder,
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: isSel ? AppColors.deepJade : Colors.transparent,
                                  borderRadius: AppRadius.smBorder,
                                ),
                                child: Text(
                                  opt,
                                  textAlign: TextAlign.center,
                                  style: AppTypography.caption.copyWith(
                                    fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                                    color: isSel ? Colors.white : AppColors.charcoal,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Key Benefits
                    Text('What unlocks with Professional:', style: AppTypography.sectionTitle.copyWith(fontSize: 15)),
                    const SizedBox(height: 12),
                    ...proPlan.features.map(
                      (feat) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle, size: 18, color: AppColors.deepJade),
                            const SizedBox(width: 10),
                            Expanded(child: Text(feat, style: AppTypography.body.copyWith(fontSize: 13.5))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              AppButton(
                label: 'Continue to Checkout',
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.paymentMethod, arguments: proPlan);
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

