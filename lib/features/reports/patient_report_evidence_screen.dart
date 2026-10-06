import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../models/mock/mock_models.dart';
import '../../shared/widgets/evidence_card.dart';
import '../../app/routes/app_routes.dart';

class PatientReportEvidenceScreen extends StatelessWidget {
  final MockConsultation? consultation;

  const PatientReportEvidenceScreen({super.key, this.consultation});

  @override
  Widget build(BuildContext context) {
    final c = consultation ?? MockData.consultations.first;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Clinical Evidence Traceability', style: AppTypography.cardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync_alt_outlined),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.evidenceTranscript, arguments: c);
            },
            tooltip: 'Trace to Transcript',
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
            // Traceability Header Banner
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
                    children: [
                      const Icon(Icons.hub_outlined, color: AppColors.deepJade, size: 20),
                      const SizedBox(width: 8),
                      Text('Transparent Diagnostic Lineage', style: AppTypography.cardTitle.copyWith(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'AI Diagnostic Suggestion ➔ Clinical Evidence ➔ Audio Timestamp',
                    style: AppTypography.metadata.copyWith(color: AppColors.deepJade, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tap any timestamp to jump directly to the exact point in the dialogue transcript.',
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            ...c.evidenceList.map((ev) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: EvidenceCard(
                  evidence: ev,
                  onJumpToTimestamp: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.evidenceTranscript,
                      arguments: {'consultation': c, 'activeTimestamp': ev.timestamp},
                    );
                  },
                ),
              );
            }),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

