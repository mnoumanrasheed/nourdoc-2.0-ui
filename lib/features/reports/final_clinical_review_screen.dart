import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../models/mock/mock_models.dart';
import '../../shared/widgets/app_button.dart';
import '../../app/routes/app_routes.dart';

class FinalClinicalReviewScreen extends StatefulWidget {
  final MockConsultation? consultation;

  const FinalClinicalReviewScreen({super.key, this.consultation});

  @override
  State<FinalClinicalReviewScreen> createState() => _FinalClinicalReviewScreenState();
}

class _FinalClinicalReviewScreenState extends State<FinalClinicalReviewScreen> {
  bool _isRiskReviewed = true;
  bool _isCodingConfirmed = true;
  bool _isEvidenceVerified = true;
  bool _isSoapApproved = true;
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.consultation ?? MockData.consultations.first;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Final Clinical Sign-Off', style: AppTypography.cardTitle),
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
                    // Patient Meta
                    Container(
                      padding: const EdgeInsets.all(14),
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
                              Text(c.patientName, style: AppTypography.cardTitle.copyWith(fontSize: 16)),
                              Text(c.id, style: AppTypography.caption.copyWith(color: AppColors.deepJade, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text('${c.patientAge}y ${c.patientGender} • ${c.careSetting.label} • ${c.primaryDiagnosis}', style: AppTypography.caption),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text('Clinician Attestation Checklist', style: AppTypography.sectionTitle.copyWith(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text(
                      'Verify each section to complete medical documentation and dispatch to EHR repository.',
                      style: AppTypography.caption,
                    ),
                    const SizedBox(height: 14),

                    // Section 1: SOAP Documentation
                    _buildCheckCard(
                      title: 'Clinical SOAP Note Approved',
                      subtitle: 'Subjective, Objective, Assessment, and Plan reviewed for clinical fidelity.',
                      icon: Icons.notes_outlined,
                      value: _isSoapApproved,
                      onChanged: (v) => setState(() => _isSoapApproved = v ?? false),
                    ),
                    const SizedBox(height: 12),

                    // Section 2: Medical Coding
                    _buildCheckCard(
                      title: 'ICD-10 & CPT Billing Codes Confirmed',
                      subtitle: '${c.codings.length} diagnostic and procedural codes confirmed under practitioner license.',
                      icon: Icons.receipt_long_outlined,
                      value: _isCodingConfirmed,
                      onChanged: (v) => setState(() => _isCodingConfirmed = v ?? false),
                    ),
                    const SizedBox(height: 12),

                    // Section 3: Clinical Risk
                    _buildCheckCard(
                      title: 'AI Clinical Risk Signals Addressed',
                      subtitle: 'Potential drug interactions and follow-up flags reviewed.',
                      icon: Icons.warning_amber_rounded,
                      value: _isRiskReviewed,
                      onChanged: (v) => setState(() => _isRiskReviewed = v ?? false),
                    ),
                    const SizedBox(height: 12),

                    // Section 4: Traceable Evidence
                    _buildCheckCard(
                      title: 'Clinical Evidence Alignment Validated',
                      subtitle: 'Dialogue statements corroborated with objective exam findings.',
                      icon: Icons.search_outlined,
                      value: _isEvidenceVerified,
                      onChanged: (v) => setState(() => _isEvidenceVerified = v ?? false),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),

              AppButton(
                label: 'Review & Confirm Sign-Off',
                icon: Icons.verified_rounded,
                isLoading: _isSubmitting,
                onPressed: () {
                  final navigator = Navigator.of(context);
                  final messenger = ScaffoldMessenger.of(context);
                  setState(() => _isSubmitting = true);
                  Future.delayed(const Duration(milliseconds: 700), () {
                    if (!mounted) return;
                    setState(() => _isSubmitting = false);
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text('Encounter successfully signed off and stored in clinical registry.'),
                        backgroundColor: AppColors.deepJade,
                      ),
                    );
                    navigator.pushNamedAndRemoveUntil(AppRoutes.mainNav, (r) => false);
                  });
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.mdBorder,
        border: Border.all(
          color: value ? AppColors.deepJade.withOpacity(0.4) : AppColors.border,
          width: value ? 1.5 : 1.0,
        ),
      ),
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.deepJade,
        title: Text(title, style: AppTypography.cardTitle.copyWith(fontSize: 14)),
        subtitle: Text(subtitle, style: AppTypography.caption),
        secondary: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.paleJade,
            borderRadius: AppRadius.smBorder,
          ),
          child: Icon(icon, color: AppColors.deepJade, size: 20),
        ),
      ),
    );
  }
}
