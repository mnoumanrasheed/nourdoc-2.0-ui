import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../models/mock/mock_models.dart';
import '../../shared/widgets/coding_card.dart';

class PatientReportCodingScreen extends StatefulWidget {
  final MockConsultation? consultation;

  const PatientReportCodingScreen({super.key, this.consultation});

  @override
  State<PatientReportCodingScreen> createState() => _PatientReportCodingScreenState();
}

class _PatientReportCodingScreenState extends State<PatientReportCodingScreen> {
  late List<MockCoding> _codings;

  @override
  void initState() {
    super.initState();
    final c = widget.consultation ?? MockData.consultations.first;
    _codings = List.from(c.codings);
  }

  void _toggleCoding(int index) {
    setState(() {
      final current = _codings[index];
      _codings[index] = MockCoding(
        code: current.code,
        description: current.description,
        category: current.category,
        isConfirmed: !current.isConfirmed,
        confidence: current.confidence,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final icd10List = _codings.where((c) => c.category == 'ICD-10').toList();
    final cptList = _codings.where((c) => c.category == 'CPT').toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Medical Coding (ICD-10 & CPT)', style: AppTypography.cardTitle),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 16,
          ),
          children: [
            // Clinical Oversight Notice Banner
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.paleJade.withOpacity(0.4),
                borderRadius: AppRadius.mdBorder,
                border: Border.all(color: AppColors.deepJade.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified_user_outlined, color: AppColors.deepJade, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Clinician Oversight: All suggested diagnostic (ICD-10) and procedural (CPT) codes require clinician confirmation prior to EHR billing dispatch.',
                      style: AppTypography.caption.copyWith(color: AppColors.deepJade, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ICD-10 Section
            Row(
              children: [
                Container(
                  width: 4,
                  height: 16,
                  color: AppColors.deepJade,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'ICD-10 Diagnostic Codes',
                    style: AppTypography.sectionTitle.copyWith(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...icd10List.map((code) {
              final idx = _codings.indexOf(code);
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CodingCard(
                  coding: code,
                  onToggleConfirm: () => _toggleCoding(idx),
                ),
              );
            }),
            const SizedBox(height: 20),

            // CPT Section
            Row(
              children: [
                Container(
                  width: 4,
                  height: 16,
                  color: AppColors.indigo,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'CPT Procedure & Service Codes',
                    style: AppTypography.sectionTitle.copyWith(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...cptList.map((code) {
              final idx = _codings.indexOf(code);
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CodingCard(
                  coding: code,
                  onToggleConfirm: () => _toggleCoding(idx),
                ),
              );
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

