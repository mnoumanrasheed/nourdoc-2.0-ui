import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_text_field.dart';
import '../../app/routes/app_routes.dart';

class StripePaymentScreen extends StatefulWidget {
  const StripePaymentScreen({super.key});

  @override
  State<StripePaymentScreen> createState() => _StripePaymentScreenState();
}

class _StripePaymentScreenState extends State<StripePaymentScreen> {
  final _cardNumberController = TextEditingController(text: '4242 •••• •••• 4242');
  final _expController = TextEditingController(text: '12/28');
  final _cvvController = TextEditingController(text: '881');
  final _nameController = TextEditingController(text: 'Dr. Muhammad Nouman');
  bool _isProcessing = false;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _submitPayment() {
    setState(() => _isProcessing = true);
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() => _isProcessing = false);
        Navigator.of(context).pushReplacementNamed(AppRoutes.paymentSuccess);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Credit / Debit Card Checkout', style: AppTypography.cardTitle),
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
              // Amount banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.mdBorder,
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('NourDoc Professional', style: AppTypography.cardTitle.copyWith(fontSize: 15)),
                        Text('Monthly Medical License', style: AppTypography.caption),
                      ],
                    ),
                    Text('\$99.00 USD', style: AppTypography.pageTitle.copyWith(fontSize: 20, color: AppColors.deepJade)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Card details
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
                      label: 'Cardholder Name',
                      controller: _nameController,
                      prefixIcon: const Icon(Icons.person_outline, size: 20),
                    ),
                    const SizedBox(height: 12),
                    AppTextField(
                      label: 'Card Number',
                      controller: _cardNumberController,
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.credit_card, size: 20),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            label: 'Expiry Date',
                            controller: _expController,
                            hintText: 'MM/YY',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppTextField(
                            label: 'CVC / CVV',
                            controller: _cvvController,
                            hintText: '3 digits',
                            obscureText: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_outline, size: 14, color: AppColors.slate),
                  const SizedBox(width: 6),
                  Text('256-bit encrypted secure checkout via Stripe', style: AppTypography.caption),
                ],
              ),

              const Spacer(),

              AppButton(
                label: 'Pay \$99.00 & Activate Workspace',
                isLoading: _isProcessing,
                onPressed: _submitPayment,
              ),
              const SizedBox(height: 8),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(AppRoutes.paymentFailed);
                  },
                  child: Text('Simulate Failure State', style: AppTypography.caption.copyWith(color: AppColors.rose)),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

