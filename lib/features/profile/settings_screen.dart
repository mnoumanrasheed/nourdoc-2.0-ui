import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _ambientNoiseFiltering = true;
  bool _autoGenerateSoap = true;
  bool _highConfidenceAlertsOnly = false;
  final String _preferredLanguage = 'English (US Clinical)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Practice Preferences', style: AppTypography.cardTitle),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 16,
          ),
          children: [
            Text('Clinical AI Tuning', style: AppTypography.label),
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
                    title: Text('Ambient Noise Filtering', style: AppTypography.bodyMedium),
                    subtitle: Text('Suppresses hospital background chatter and monitors', style: AppTypography.caption),
                    value: _ambientNoiseFiltering,
                    activeColor: AppColors.deepJade,
                    onChanged: (v) => setState(() => _ambientNoiseFiltering = v),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: Text('Auto-Generate SOAP Post-Recording', style: AppTypography.bodyMedium),
                    subtitle: Text('Immediately begins staging SOAP note synthesis', style: AppTypography.caption),
                    value: _autoGenerateSoap,
                    activeColor: AppColors.deepJade,
                    onChanged: (v) => setState(() => _autoGenerateSoap = v),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: Text('High Confidence Risk Signals Only', style: AppTypography.bodyMedium),
                    subtitle: Text('Suppresses low-threshold warnings (>90% threshold)', style: AppTypography.caption),
                    value: _highConfidenceAlertsOnly,
                    activeColor: AppColors.deepJade,
                    onChanged: (v) => setState(() => _highConfidenceAlertsOnly = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text('Language & Terminology', style: AppTypography.label),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppRadius.mdBorder,
                border: Border.all(color: AppColors.border),
              ),
              child: ListTile(
                title: Text('Clinical Lexicon Dialect', style: AppTypography.bodyMedium),
                subtitle: Text(_preferredLanguage, style: AppTypography.caption.copyWith(color: AppColors.deepJade, fontWeight: FontWeight.bold)),
                trailing: const Icon(Icons.chevron_right, size: 20),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Dialect configured to English (US Clinical)')),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
