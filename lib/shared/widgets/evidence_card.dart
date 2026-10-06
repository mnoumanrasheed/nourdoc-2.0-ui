import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_models.dart';

class EvidenceCard extends StatelessWidget {
  final MockEvidence evidence;
  final VoidCallback onJumpToTimestamp;

  const EvidenceCard({
    super.key,
    required this.evidence,
    required this.onJumpToTimestamp,
  });

  @override
  Widget build(BuildContext context) {
    Color typeColor;
    if (evidence.type == 'Patient Evidence') {
      typeColor = AppColors.deepJade;
    } else if (evidence.type == 'External Reference') {
      typeColor = AppColors.clinicalBlue;
    } else {
      typeColor = AppColors.indigo;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.mdBorder,
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.subtle,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: typeColor.withOpacity(0.1),
                  borderRadius: AppRadius.xsBorder,
                ),
                child: Text(
                  evidence.type,
                  style: AppTypography.caption.copyWith(
                    color: typeColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              InkWell(
                onTap: onJumpToTimestamp,
                borderRadius: AppRadius.xsBorder,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.paleJade,
                    borderRadius: AppRadius.xsBorder,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.play_circle_outline, size: 14, color: AppColors.deepJade),
                      const SizedBox(width: 4),
                      Text(
                        evidence.timestamp,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.deepJade,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            evidence.text,
            style: AppTypography.body.copyWith(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: AppColors.charcoal,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.record_voice_over_outlined, size: 14, color: AppColors.slate),
              const SizedBox(width: 6),
              Text(
                evidence.speaker,
                style: AppTypography.caption.copyWith(
                  color: AppColors.slate,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

