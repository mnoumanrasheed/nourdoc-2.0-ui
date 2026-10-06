import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/app_button.dart';
import '../../app/routes/app_routes.dart';

class PaymentMethodScreen extends StatefulWidget {
  final dynamic plan;

  const PaymentMethodScreen({super.key, this.plan});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String _selectedMethod = 'stripe';

  void _proceedToPayment() {
    switch (_selectedMethod) {
      case 'stripe':
        Navigator.of(context).pushNamed(AppRoutes.stripePayment);
        break;
      case 'jazzcash':
        Navigator.of(context).pushNamed(AppRoutes.jazzCashPayment);
        break;
      case 'easypaisa':
        Navigator.of(context).pushNamed(AppRoutes.easyPaisaPayment);
        break;
      case 'bank':
        Navigator.of(context).pushNamed(AppRoutes.bankTransfer);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Select Payment Method', style: AppTypography.cardTitle),
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
              Text('Choose Billing Method', style: AppTypography.sectionTitle),
              const SizedBox(height: 6),
              Text(
                'Select a payment channel to activate your NourDoc clinical workspace.',
                style: AppTypography.body.copyWith(color: AppColors.slate),
              ),
              const SizedBox(height: 20),

              _buildPaymentOption(
                id: 'stripe',
                title: 'Credit / Debit Card (Stripe)',
                subtitle: 'Visa, MasterCard, American Express',
                icon: Icons.credit_card_outlined,
                color: AppColors.deepJade,
              ),
              const SizedBox(height: 12),

              _buildPaymentOption(
                id: 'jazzcash',
                title: 'JazzCash Mobile Wallet',
                subtitle: 'Pay directly via JazzCash mobile account',
                icon: Icons.account_balance_wallet_outlined,
                color: AppColors.warmAmber,
              ),
              const SizedBox(height: 12),

              _buildPaymentOption(
                id: 'easypaisa',
                title: 'EasyPaisa Mobile Wallet',
                subtitle: 'Instant mobile account debit or voucher',
                icon: Icons.phone_android_outlined,
                color: AppColors.clinicalBlue,
              ),
              const SizedBox(height: 12),

              _buildPaymentOption(
                id: 'bank',
                title: 'Direct Bank Wire / IBAN Transfer',
                subtitle: 'Institutional hospital invoices & bank transfer',
                icon: Icons.account_balance_outlined,
                color: AppColors.indigo,
              ),

              const Spacer(),

              AppButton(
                label: 'Continue to Payment',
                onPressed: _proceedToPayment,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required String id,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    final isSel = _selectedMethod == id;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.mdBorder,
        border: Border.all(
          color: isSel ? color : AppColors.border,
          width: isSel ? 2.0 : 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => setState(() => _selectedMethod = id),
          borderRadius: AppRadius.mdBorder,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTypography.cardTitle.copyWith(fontSize: 14)),
                      const SizedBox(height: 2),
                      Text(subtitle, style: AppTypography.caption),
                    ],
                  ),
                ),
                Radio<String>(
                  value: id,
                  groupValue: _selectedMethod,
                  activeColor: color,
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedMethod = val);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

