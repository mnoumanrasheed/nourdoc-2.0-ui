import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../models/mock/mock_models.dart';
import '../../shared/widgets/risk_card.dart';
import '../../app/routes/app_routes.dart';

class PatientReportRiskScreen extends StatefulWidget {
  final MockConsultation? consultation;

  const PatientReportRiskScreen({super.key, this.consultation});

  @override
  State<PatientReportRiskScreen> createState() => _PatientReportRiskScreenState();
}

class _PatientReportRiskScreenState extends State<PatientReportRiskScreen> {
  late List<MockRiskSignal> _signals;

  @override
  void initState() {
    super.initState();
    final c = widget.consultation ?? MockData.consultations.first;
    _signals = List.from(c.riskSignals);
  }

  void _dismissSignal(int index) {
    setState(() {
      _signals.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Risk signal dismissed by clinician')),
    );
  }

  void _confirmSignal(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Risk signal confirmed & documented in note')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('AI Clinical Risk Review', style: AppTypography.cardTitle),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 16,
          ),
          children: [
            // Mandatory Clinical Safety Warning Banner
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.amberLight,
                borderRadius: AppRadius.mdBorder,
                border: Border.all(color: AppColors.warmAmber.withOpacity(0.4)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, color: AppColors.warmAmber, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Important Safety Principle',
                          style: AppTypography.cardTitle.copyWith(fontSize: 14, color: AppColors.charcoal),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'No AI signal detected does NOT guarantee absence of clinical risk. Clinician judgment remains paramount.',
                          style: AppTypography.caption.copyWith(color: AppColors.charcoal, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text('Active Diagnostic & Treatment Flags (${_signals.length})', style: AppTypography.sectionTitle.copyWith(fontSize: 16)),
            const SizedBox(height: 10),

            if (_signals.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text('All flagged risk items reviewed and reconciled.', style: AppTypography.body),
                ),
              )
            else
              ...List.generate(_signals.length, (index) {
                final sig = _signals[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: RiskCard(
                    signal: sig,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.riskDetail, arguments: sig);
                    },
                    onDismiss: () => _dismissSignal(index),
                    onConfirm: () => _confirmSignal(index),
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

