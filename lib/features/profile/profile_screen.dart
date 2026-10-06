import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/brand_logo.dart';
import '../../app/routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Clinician Profile', style: AppTypography.cardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.settings);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 16,
          ),
          children: [
            // Doctor Profile Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppRadius.mdBorder,
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: AppColors.paleJade,
                    child: Text(
                      'DN',
                      style: AppTypography.pageTitle.copyWith(
                        color: AppColors.deepJade,
                        fontSize: 26,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Dr. Muhammad Nouman, MD', style: AppTypography.cardTitle.copyWith(fontSize: 18)),
                  const SizedBox(height: 4),
                  Text('Internal Medicine Specialist', style: AppTypography.metadata.copyWith(color: AppColors.deepJade, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text('Central Teaching Hospital • PMDC: PMC-92810-A', style: AppTypography.caption),
                  const SizedBox(height: 16),

                  // Subscription Status Badge inside Profile
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.paleJade,
                      borderRadius: AppRadius.smBorder,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.verified, size: 16, color: AppColors.deepJade),
                            const SizedBox(width: 8),
                            Text('Professional Workspace', style: AppTypography.caption.copyWith(fontWeight: FontWeight.bold, color: AppColors.deepJade)),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRoutes.mySubscription);
                          },
                          child: Text(
                            'Manage',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.deepJade,
                              fontWeight: FontWeight.w800,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Practice & Documentation
            Text('Workspace Management', style: AppTypography.label),
            const SizedBox(height: 8),
            _buildSettingsGroup([
              _buildTile(
                icon: Icons.history_edu_outlined,
                title: 'Previous Clinical Reports',
                subtitle: 'Archive of past consultations and sign-offs',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.previousReports),
              ),
              _buildTile(
                icon: Icons.star_outline,
                title: 'Plans & Pricing',
                subtitle: 'View Free, Starter, Pro, and Enterprise tiers',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.plans),
              ),
              _buildTile(
                icon: Icons.receipt_long_outlined,
                title: 'Billing & Invoices',
                subtitle: 'Receipts, tax records, and payment options',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.invoiceHistory),
              ),
              _buildTile(
                icon: Icons.speed_outlined,
                title: 'Encounter Usage & Limits',
                subtitle: 'Resource quota and monthly encounters',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.usageLimits),
              ),
            ]),
            const SizedBox(height: 16),

            // Security & Settings
            Text('Account & Preferences', style: AppTypography.label),
            const SizedBox(height: 8),
            _buildSettingsGroup([
              _buildTile(
                icon: Icons.notifications_none_outlined,
                title: 'Notification Preferences',
                subtitle: 'Risk alerts, report sign-offs, and reminders',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.notificationSettings),
              ),
              _buildTile(
                icon: Icons.security_outlined,
                title: 'Clinical Security & 2FA',
                subtitle: 'Two-factor authentication, biometric sign-in',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.security),
              ),
              _buildTile(
                icon: Icons.view_quilt_outlined,
                title: 'Empty States Showcase',
                subtitle: 'Review standardized clinical empty UI states',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.emptyStatesShowcase),
              ),
              _buildTile(
                icon: Icons.error_outline_rounded,
                title: 'Error States Showcase',
                subtitle: 'Review standardized clinical error UI states',
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.errorStatesShowcase),
              ),
            ]),
            const SizedBox(height: 20),

            // Logout
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppRadius.mdBorder,
                border: Border.all(color: AppColors.border),
              ),
              child: ListTile(
                leading: const Icon(Icons.logout, color: AppColors.rose),
                title: Text('Sign Out of Workspace', style: AppTypography.cardTitle.copyWith(fontSize: 14, color: AppColors.rose)),
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.signIn, (r) => false);
                },
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  const NourDocLogo(height: 22, showText: false),
                  const SizedBox(height: 6),
                  Text('NourDoc Intelligent Clinical Workspace v2.0.0', style: AppTypography.caption),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.mdBorder,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.deepJade, size: 22),
      title: Text(title, style: AppTypography.cardTitle.copyWith(fontSize: 14)),
      subtitle: Text(subtitle, style: AppTypography.caption),
      trailing: const Icon(Icons.chevron_right, size: 20, color: AppColors.slateLight),
      onTap: onTap,
    );
  }
}

