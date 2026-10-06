import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../models/mock/mock_models.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/clinical_badges.dart';

class RiskDetailScreen extends StatefulWidget {
  final MockRiskSignal? signal;

  const RiskDetailScreen({super.key, this.signal});

  @override
  State<RiskDetailScreen> createState() => _RiskDetailScreenState();
}

class _RiskDetailScreenState extends State<RiskDetailScreen> {
  final _noteController = TextEditingController();
  late MockRiskSignal _signal;

  @override
  void initState() {
    super.initState();
    _signal = widget.signal ?? MockData.riskSignals.first;
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Risk Signal Detail', style: AppTypography.cardTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Signal Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.mdBorder,
                  border: Border.all(color: _signal.severityColor.withOpacity(0.4), width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_signal.severity, style: AppTypography.metadata.copyWith(color: _signal.severityColor, fontWeight: FontWeight.w700)),
                        ConfidenceBadge(confidence: _signal.confidence),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(_signal.title, style: AppTypography.cardTitle.copyWith(fontSize: 17)),
                    const SizedBox(height: 8),
                    Text(_signal.description, style: AppTypography.body),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Why Flagged Section
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
                    Text('Clinical Rationale & Algorithmic Trigger', style: AppTypography.cardTitle.copyWith(fontSize: 14)),
                    const SizedBox(height: 8),
                    Text(_signal.whyFlagged, style: AppTypography.body.copyWith(color: AppColors.charcoal)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 14, color: AppColors.slate),
                        const SizedBox(width: 4),
                        Text('Captured in dialogue at ${_signal.timestamp}', style: AppTypography.caption),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Clinician Override / Add Clinical Note
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
                    Text('Add Clinician Counter-Note', style: AppTypography.cardTitle.copyWith(fontSize: 14)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _noteController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Enter clinical rationale for override or follow-up plan...',
                        fillColor: AppColors.clinicalMist,
                        border: OutlineInputBorder(borderRadius: AppRadius.smBorder),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Actions
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Signal dismissed with clinical justification')),
                        );
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.rose,
                        side: const BorderSide(color: AppColors.rose),
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(borderRadius: AppRadius.mdBorder),
                      ),
                      child: const Text('Dismiss Signal'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      label: 'Confirm & Note',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Risk item incorporated into clinical plan')),
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

