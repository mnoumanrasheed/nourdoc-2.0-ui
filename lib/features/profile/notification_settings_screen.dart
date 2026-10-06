import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _reportReadyAlerts = true;
  bool _urgentRiskSignals = true;
  bool _codingConfirmations = true;
  bool _subscriptionBilling = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Notification Alerts', style: AppTypography.cardTitle),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 16,
          ),
          children: [
            Text('Clinical Alerts', style: AppTypography.label),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppRadius.mdBorder,
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    title: Text('Report Ready for Sign-Off', style: AppTypography.bodyMedium),
                    subtitle: Text('Push notification when AI finishes SOAP generation', style: AppTypography.caption),
                    value: _reportReadyAlerts,
                    activeColor: AppColors.deepJade,
                    onChanged: (v) => setState(() => _reportReadyAlerts = v),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: Text('Urgent Clinical Risk Signals', style: AppTypography.bodyMedium),
                    subtitle: Text('Immediate notification for high-severity medication interactions', style: AppTypography.caption),
                    value: _urgentRiskSignals,
                    activeColor: AppColors.rose,
                    onChanged: (v) => setState(() => _urgentRiskSignals = v),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: Text('Coding Confirmation Requests', style: AppTypography.bodyMedium),
                    subtitle: Text('Reminders for unsigned ICD-10 & CPT codes', style: AppTypography.caption),
                    value: _codingConfirmations,
                    activeColor: AppColors.deepJade,
                    onChanged: (v) => setState(() => _codingConfirmations = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text('Billing & Account Alerts', style: AppTypography.label),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppRadius.mdBorder,
                border: Border.all(color: AppColors.border),
              ),
              child: SwitchListTile(
                title: Text('Subscription & Invoice Notices', style: AppTypography.bodyMedium),
                subtitle: Text('Receipts, renewals, and quota threshold alerts', style: AppTypography.caption),
                value: _subscriptionBilling,
                activeColor: AppColors.deepJade,
                onChanged: (v) => setState(() => _subscriptionBilling = v),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

