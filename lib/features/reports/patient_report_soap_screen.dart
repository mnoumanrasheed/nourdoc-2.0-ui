import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../models/mock/mock_models.dart';

class PatientReportSoapScreen extends StatelessWidget {
  final MockConsultation? consultation;

  const PatientReportSoapScreen({super.key, this.consultation});

  @override
  Widget build(BuildContext context) {
    final c = consultation ?? MockData.consultations.first;
    final soap = c.soap;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('SOAP Clinical Documentation', style: AppTypography.cardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('SOAP note copied to clipboard for EHR')),
              );
            },
            tooltip: 'Copy Note',
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Clinician edit mode activated')),
              );
            },
            tooltip: 'Edit Note',
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
            // Patient Bar
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppRadius.smBorder,
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${c.patientName} (${c.id})', style: AppTypography.cardTitle.copyWith(fontSize: 14)),
                  Text(c.dateTime, style: AppTypography.caption),
                ],
              ),
            ),
            const SizedBox(height: 14),

            _buildSection(
              tag: 'S',
              title: 'Subjective',
              color: AppColors.deepJade,
              content: soap.subjective,
              badge: 'Patient Symptoms & History',
            ),
            const SizedBox(height: 14),

            _buildSection(
              tag: 'O',
              title: 'Objective',
              color: AppColors.clinicalBlue,
              content: soap.objective,
              badge: 'Physical Exam & Vitals',
            ),
            const SizedBox(height: 14),

            _buildSection(
              tag: 'A',
              title: 'Assessment',
              color: AppColors.warmAmber,
              content: soap.assessment,
              badge: 'Diagnostic Formulations',
            ),
            const SizedBox(height: 14),

            _buildSection(
              tag: 'P',
              title: 'Plan',
              color: AppColors.indigo,
              content: soap.plan,
              badge: 'Therapeutic Orders & Follow-up',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String tag,
    required String title,
    required Color color,
    required String content,
    required String badge,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.mdBorder,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.06),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              border: Border(bottom: BorderSide(color: color.withOpacity(0.15))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          tag,
                          style: AppTypography.metadata.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: AppTypography.cardTitle.copyWith(
                        fontSize: 15,
                        color: color,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Text(
                  badge,
                  style: AppTypography.caption.copyWith(color: AppColors.slate, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              content,
              style: AppTypography.body.copyWith(
                height: 1.5,
                color: AppColors.charcoal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
