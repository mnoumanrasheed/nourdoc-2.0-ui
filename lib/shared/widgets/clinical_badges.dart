import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_models.dart';

class CareSettingBadge extends StatelessWidget {
  final CareSetting setting;
  final bool compact;

  const CareSettingBadge({
    super.key,
    required this.setting,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    Color getBgColor() {
      switch (setting) {
        case CareSetting.emergency:
          return AppColors.roseLight;
        case CareSetting.opd:
          return AppColors.paleJade;
        case CareSetting.ipd:
          return AppColors.softBlue;
        case CareSetting.ot:
          return AppColors.indigoLight;
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: getBgColor(),
        borderRadius: AppRadius.smBorder,
        border: Border.all(color: setting.color.withOpacity(0.25), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(setting.icon, size: compact ? 12 : 14, color: setting.color),
          const SizedBox(width: 4),
          Text(
            setting.label,
            style: AppTypography.metadata.copyWith(
              color: setting.color,
              fontWeight: FontWeight.w700,
              fontSize: compact ? 11 : 12,
            ),
          ),
        ],
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  final ConsultationStatus status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    switch (status) {
      case ConsultationStatus.ready:
        bg = AppColors.paleJade;
        break;
      case ConsultationStatus.processing:
        bg = AppColors.amberLight;
        break;
      case ConsultationStatus.delayed:
        bg = AppColors.roseLight;
        break;
      case ConsultationStatus.completed:
        bg = AppColors.softBlue;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.smBorder,
        border: Border.all(color: status.color.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: status.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              status.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.metadata.copyWith(
                color: status.color,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ConfidenceBadge extends StatelessWidget {
  final double confidence;

  const ConfidenceBadge({super.key, required this.confidence});

  @override
  Widget build(BuildContext context) {
    final pct = (confidence * 100).toInt();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.paleJade,
        borderRadius: AppRadius.smBorder,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_awesome, size: 12, color: AppColors.deepJade),
          const SizedBox(width: 4),
          Text(
            '$pct% confidence',
            style: AppTypography.caption.copyWith(
              color: AppColors.deepJade,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

