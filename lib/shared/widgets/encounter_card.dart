import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_models.dart';
import 'clinical_badges.dart';

class NeedsAttentionCard extends StatelessWidget {
  final MockConsultation consultation;
  final VoidCallback onTap;

  const NeedsAttentionCard({
    super.key,
    required this.consultation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color accentColor;
    String badgeLabel;
    IconData leadingIcon;

    if (consultation.careSetting == CareSetting.emergency) {
      accentColor = AppColors.rose;
      badgeLabel = 'EMERGENCY';
      leadingIcon = Icons.emergency_outlined;
    } else if (consultation.status == ConsultationStatus.ready) {
      accentColor = AppColors.warmAmber;
      badgeLabel = 'CLINICAL REVIEW';
      leadingIcon = Icons.warning_amber_rounded;
    } else {
      accentColor = AppColors.clinicalBlue;
      badgeLabel = 'ACTION REQUIRED';
      leadingIcon = Icons.assignment_outlined;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.mdBorder,
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.subtle,
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Left accent bar matching Figma
                Container(
                  width: 4.5,
                  color: accentColor,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    child: Row(
                      children: [
                        // Leading circular icon
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: accentColor.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(leadingIcon, color: accentColor, size: 20),
                        ),
                        const SizedBox(width: 12),
                        // Patient details & badge
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                                decoration: BoxDecoration(
                                  color: accentColor.withValues(alpha: 0.12),
                                  borderRadius: AppRadius.xsBorder,
                                ),
                                child: Text(
                                  badgeLabel,
                                  style: AppTypography.caption.copyWith(
                                    color: accentColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 10,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                consultation.patientName,
                                style: AppTypography.cardTitle.copyWith(fontSize: 15),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${consultation.patientAge} yrs • ${consultation.patientGender} • ${consultation.primaryDiagnosis}',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.slate,
                                  fontSize: 11.5,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.chevron_right, color: AppColors.slateLight, size: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EncounterCard extends StatelessWidget {
  final MockConsultation consultation;
  final VoidCallback onTap;

  const EncounterCard({
    super.key,
    required this.consultation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color avatarBg;
    Color avatarText;

    if (consultation.careSetting == CareSetting.emergency) {
      avatarBg = AppColors.roseLight;
      avatarText = AppColors.rose;
    } else {
      avatarBg = AppColors.paleJade;
      avatarText = AppColors.deepJade;
    }

    final initials = consultation.patientName
        .split(' ')
        .map((p) => p.isNotEmpty ? p[0] : '')
        .take(2)
        .join();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.mdBorder,
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.subtle,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.mdBorder,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                // Patient Initials Avatar
                CircleAvatar(
                  radius: 20,
                  backgroundColor: avatarBg,
                  child: Text(
                    initials,
                    style: AppTypography.caption.copyWith(
                      color: avatarText,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Patient Info & Pill
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        consultation.patientName,
                        style: AppTypography.cardTitle.copyWith(fontSize: 15),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${consultation.patientGender} • ${consultation.patientAge} yrs • ${consultation.careSetting.label} • ${consultation.visitType.label}',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.slate,
                          fontSize: 11.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      StatusChip(status: consultation.status),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Time, duration & chevron
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      consultation.dateTime,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.slate,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.schedule, size: 12, color: AppColors.slateLight),
                        const SizedBox(width: 3),
                        Text(
                          consultation.duration,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.slateLight,
                            fontSize: 10.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Icon(Icons.chevron_right, color: AppColors.slateLight, size: 18),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
