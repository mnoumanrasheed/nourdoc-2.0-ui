import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_models.dart';
import 'clinical_badges.dart';

class RiskCard extends StatelessWidget {
  final MockRiskSignal signal;
  final VoidCallback onTap;
  final VoidCallback? onConfirm;
  final VoidCallback? onDismiss;

  const RiskCard({
    super.key,
    required this.signal,
    required this.onTap,
    this.onConfirm,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.mdBorder,
        border: Border.all(color: signal.severityColor.withOpacity(0.4), width: 1.2),
        boxShadow: AppShadows.subtle,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.mdBorder,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: signal.severityColor.withOpacity(0.12),
                        borderRadius: AppRadius.smBorder,
                      ),
                      child: Icon(
                        Icons.warning_amber_rounded,
                        color: signal.severityColor,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            signal.title,
                            style: AppTypography.cardTitle.copyWith(fontSize: 15),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Text(
                                signal.severity,
                                style: AppTypography.caption.copyWith(
                                  color: signal.severityColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 8),
                              ConfidenceBadge(confidence: signal.confidence),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: AppColors.slateLight, size: 20),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  signal.description,
                  style: AppTypography.body.copyWith(fontSize: 13, color: AppColors.charcoal),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.clinicalMist,
                    borderRadius: AppRadius.smBorder,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, size: 14, color: AppColors.slate),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Why: ${signal.whyFlagged}',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.slate,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      Text(
                        signal.timestamp,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.deepJade,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onConfirm != null && onDismiss != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: onDismiss,
                        child: Text('Dismiss', style: AppTypography.metadata.copyWith(color: AppColors.slate)),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: onConfirm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: signal.severityColor,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          minimumSize: const Size(0, 36),
                          shape: RoundedRectangleBorder(borderRadius: AppRadius.smBorder),
                        ),
                        child: Text('Acknowledge', style: AppTypography.metadata.copyWith(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

