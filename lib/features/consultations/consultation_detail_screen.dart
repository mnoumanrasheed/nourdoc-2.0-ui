import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../models/mock/mock_models.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/clinical_badges.dart';
import '../../shared/widgets/app_audio_player.dart';
import '../../app/routes/app_routes.dart';

class ConsultationDetailScreen extends StatelessWidget {
  final MockConsultation? consultation;

  const ConsultationDetailScreen({super.key, this.consultation});

  @override
  Widget build(BuildContext context) {
    final c = consultation ?? MockData.consultations.first;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Consultation #${c.id.split('-').last}', style: AppTypography.cardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
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
            // Patient & Encounter Meta Card
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c.patientName, style: AppTypography.cardTitle.copyWith(fontSize: 17)),
                          const SizedBox(height: 2),
                          Text('${c.patientAge}y • ${c.patientGender} • ${c.visitType.label}', style: AppTypography.metadata),
                        ],
                      ),
                      CareSettingBadge(setting: c.careSetting),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${c.dateTime} (${c.duration})', style: AppTypography.caption),
                      StatusChip(status: c.status),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Audio Player Card
            Text('Encounter Audio', style: AppTypography.sectionTitle.copyWith(fontSize: 15)),
            const SizedBox(height: 8),
            const AppAudioPlayer(totalDuration: '11:45'),
            const SizedBox(height: 20),

            // Navigation to Specific Report Modules
            Text('Clinical Documentation Sections', style: AppTypography.sectionTitle.copyWith(fontSize: 15)),
            const SizedBox(height: 10),

            _buildNavTile(
              context: context,
              icon: Icons.notes_outlined,
              title: 'SOAP Note',
              subtitle: 'Structured Subjective, Objective, Assessment, Plan',
              route: AppRoutes.reportSoap,
              arguments: c,
            ),
            const SizedBox(height: 10),
            _buildNavTile(
              context: context,
              icon: Icons.receipt_long_outlined,
              title: 'ICD-10 & CPT Medical Coding',
              subtitle: '${c.codings.length} Suggested billing codes ready for clinician confirmation',
              route: AppRoutes.reportCoding,
              arguments: c,
            ),
            const SizedBox(height: 10),
            _buildNavTile(
              context: context,
              icon: Icons.search_outlined,
              title: 'Clinical Evidence Traceability',
              subtitle: '${c.evidenceList.length} Quotes anchored directly to audio timestamps',
              route: AppRoutes.reportEvidence,
              arguments: c,
            ),
            const SizedBox(height: 10),
            _buildNavTile(
              context: context,
              icon: Icons.warning_amber_rounded,
              title: 'AI Clinical Risk Analysis',
              subtitle: '${c.riskSignals.length} Safety signals detected for review',
              route: AppRoutes.reportRisk,
              arguments: c,
              alertColor: AppColors.warmAmber,
            ),
            const SizedBox(height: 10),
            _buildNavTile(
              context: context,
              icon: Icons.chat_outlined,
              title: 'Verbatim Consultation Transcript',
              subtitle: 'Full speaker-separated conversation dialogue',
              route: AppRoutes.reportTranscript,
              arguments: c,
            ),

            const SizedBox(height: 24),
            AppButton(
              label: 'Proceed to Final Clinical Review',
              icon: Icons.verified_outlined,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.finalClinicalReview, arguments: c);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNavTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String route,
    required Object arguments,
    Color? alertColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.mdBorder,
        border: Border.all(color: alertColor?.withOpacity(0.4) ?? AppColors.border),
      ),
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(route, arguments: arguments);
        },
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (alertColor ?? AppColors.deepJade).withOpacity(0.12),
            borderRadius: AppRadius.smBorder,
          ),
          child: Icon(icon, color: alertColor ?? AppColors.deepJade, size: 22),
        ),
        title: Text(title, style: AppTypography.cardTitle.copyWith(fontSize: 14)),
        subtitle: Text(subtitle, style: AppTypography.caption),
        trailing: const Icon(Icons.chevron_right, color: AppColors.slateLight, size: 20),
      ),
    );
  }
}

