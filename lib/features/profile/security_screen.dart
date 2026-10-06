import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _biometricUnlock = true;
  bool _twoFactorAuth = true;
  bool _autoLockOnBackground = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Security & Compliance', style: AppTypography.cardTitle),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 16,
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.paleJade.withOpacity(0.4),
                borderRadius: AppRadius.mdBorder,
                border: Border.all(color: AppColors.deepJade.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.security, color: AppColors.deepJade, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'HIPAA & Clinical Compliance Active. Protected Health Information (PHI) is protected with biometric local encryption.',
                      style: AppTypography.caption.copyWith(color: AppColors.deepJade, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text('Device & Biometric Safeguards', style: AppTypography.label),
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
                    title: Text('Biometric Authentication', style: AppTypography.bodyMedium),
                    subtitle: Text('Require Touch ID / Face ID to access clinical encounters', style: AppTypography.caption),
                    value: _biometricUnlock,
                    activeColor: AppColors.deepJade,
                    onChanged: (v) => setState(() => _biometricUnlock = v),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: Text('Two-Factor Authentication (2FA)', style: AppTypography.bodyMedium),
                    subtitle: Text('SMS OTP verification required upon signing in', style: AppTypography.caption),
                    value: _twoFactorAuth,
                    activeColor: AppColors.deepJade,
                    onChanged: (v) => setState(() => _twoFactorAuth = v),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: Text('Auto-Lock on Background', style: AppTypography.bodyMedium),
                    subtitle: Text('Instantly locks screen if application is minimized', style: AppTypography.caption),
                    value: _autoLockOnBackground,
                    activeColor: AppColors.deepJade,
                    onChanged: (v) => setState(() => _autoLockOnBackground = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text('Active Medical Sessions', style: AppTypography.label),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppRadius.mdBorder,
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Primary Clinic Mobile Device', style: AppTypography.cardTitle.copyWith(fontSize: 14)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: AppColors.paleJade, borderRadius: AppRadius.xsBorder),
                        child: Text('Current Device', style: AppTypography.caption.copyWith(color: AppColors.deepJade, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('iOS / Android • Last active: Just now', style: AppTypography.caption),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

