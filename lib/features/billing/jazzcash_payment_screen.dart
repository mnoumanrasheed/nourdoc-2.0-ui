import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_text_field.dart';
import '../../app/routes/app_routes.dart';

class JazzCashPaymentScreen extends StatefulWidget {
  const JazzCashPaymentScreen({super.key});

  @override
  State<JazzCashPaymentScreen> createState() => _JazzCashPaymentScreenState();
}

class _JazzCashPaymentScreenState extends State<JazzCashPaymentScreen> {
  final _mobileNumberController = TextEditingController(text: '0300 1234567');
  final _cnicController = TextEditingController(text: '35201-1234567-1');
  bool _isLoading = false;

  @override
  void dispose() {
    _mobileNumberController.dispose();
    _cnicController.dispose();
    super.dispose();
  }

  void _payWithJazzCash() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.of(context).pushReplacementNamed(AppRoutes.paymentPending);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('JazzCash Payment', style: AppTypography.cardTitle),
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
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.mdBorder,
                  border: Border.all(color: AppColors.warmAmber.withOpacity(0.5)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.warmAmber.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.account_balance_wallet, color: AppColors.warmAmber, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('JazzCash Mobile Account', style: AppTypography.cardTitle.copyWith(fontSize: 15)),
                          Text('NourDoc Professional: PKR 27,500', style: AppTypography.caption),
                        ],
                      ),
                    ),
                  ],
                ),
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
                    AppTextField(
                      label: 'JazzCash Registered Mobile Number',
                      hintText: '0300 0000000',
                      controller: _mobileNumberController,
                      keyboardType: TextInputType.phone,
                      prefixIcon: const Icon(Icons.phone_iphone, size: 20),
                    ),
                    const SizedBox(height: 14),
                    AppTextField(
                      label: 'Account Holder CNIC (Last 6 Digits)',
                      hintText: '••••••',
                      controller: _cnicController,
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.badge_outlined, size: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'A prompt will appear on your mobile screen to enter your 4-digit MPIN and confirm.',
                style: AppTypography.caption,
              ),

              const Spacer(),

              AppButton(
                label: 'Send Mobile Account Request',
                isLoading: _isLoading,
                onPressed: _payWithJazzCash,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

