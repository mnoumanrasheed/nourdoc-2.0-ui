import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_models.dart';
import 'clinical_badges.dart';

class CodingCard extends StatelessWidget {
  final MockCoding coding;
  final VoidCallback onToggleConfirm;

  const CodingCard({
    super.key,
    required this.coding,
    required this.onToggleConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final isIcd = coding.category == 'ICD-10';
    final badgeColor = isIcd ? AppColors.deepJade : AppColors.indigo;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.mdBorder,
        border: Border.all(
          color: coding.isConfirmed ? AppColors.deepJade : AppColors.border,
          width: coding.isConfirmed ? 1.5 : 1.0,
        ),
        boxShadow: AppShadows.subtle,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: badgeColor.withOpacity(0.12),
                        borderRadius: AppRadius.xsBorder,
                        border: Border.all(color: badgeColor.withOpacity(0.2)),
                      ),
                      child: Text(
                        coding.category,
                        style: AppTypography.caption.copyWith(
                          color: badgeColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        coding.code,
                        style: AppTypography.cardTitle.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.charcoal,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ConfidenceBadge(confidence: coding.confidence),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            coding.description,
            style: AppTypography.body.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  coding.isConfirmed ? 'Clinician Confirmed' : 'Suggested by AI',
                  style: AppTypography.caption.copyWith(
                    color: coding.isConfirmed ? AppColors.deepJade : AppColors.slate,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: onToggleConfirm,
                icon: Icon(
                  coding.isConfirmed ? Icons.check_circle : Icons.check_circle_outline,
                  size: 16,
                  color: coding.isConfirmed ? Colors.white : AppColors.deepJade,
                ),
                label: Text(
                  coding.isConfirmed ? 'Confirmed' : 'Confirm Code',
                  style: AppTypography.caption.copyWith(
                    fontWeight: FontWeight.w600,
                    color: coding.isConfirmed ? Colors.white : AppColors.deepJade,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: coding.isConfirmed ? AppColors.deepJade : Colors.transparent,
                  side: BorderSide(
                    color: coding.isConfirmed ? AppColors.deepJade : AppColors.deepJade.withOpacity(0.5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  minimumSize: const Size(0, 32),
                  shape: RoundedRectangleBorder(borderRadius: AppRadius.smBorder),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

