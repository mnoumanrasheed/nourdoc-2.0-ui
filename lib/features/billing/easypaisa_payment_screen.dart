import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_text_field.dart';
import '../../app/routes/app_routes.dart';

class EasyPaisaPaymentScreen extends StatefulWidget {
  const EasyPaisaPaymentScreen({super.key});

  @override
  State<EasyPaisaPaymentScreen> createState() => _EasyPaisaPaymentScreenState();
}

class _EasyPaisaPaymentScreenState extends State<EasyPaisaPaymentScreen> {
  final _mobileNumberController = TextEditingController(text: '0345 9876543');
  bool _isLoading = false;

  @override
  void dispose() {
    _mobileNumberController.dispose();
    super.dispose();
  }

  void _payWithEasyPaisa() {
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
        title: Text('EasyPaisa Payment', style: AppTypography.cardTitle),
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
                  border: Border.all(color: AppColors.clinicalBlue.withOpacity(0.5)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.clinicalBlue.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.phone_android, color: AppColors.clinicalBlue, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('EasyPaisa Direct Account Debit', style: AppTypography.cardTitle.copyWith(fontSize: 15)),
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
                      label: 'EasyPaisa Registered Mobile Number',
                      hintText: '0345 0000000',
                      controller: _mobileNumberController,
                      keyboardType: TextInputType.phone,
                      prefixIcon: const Icon(Icons.phone_iphone, size: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Open your EasyPaisa app or respond to the push notification to approve payment with your 5-digit PIN.',
                style: AppTypography.caption,
              ),

              const Spacer(),

              AppButton(
                label: 'Confirm EasyPaisa Checkout',
                isLoading: _isLoading,
                onPressed: _payWithEasyPaisa,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

