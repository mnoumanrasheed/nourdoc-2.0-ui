import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_models.dart';
import 'clinical_badges.dart';

class PatientCard extends StatelessWidget {
  final MockPatient patient;
  final VoidCallback onTap;
  final VoidCallback? onStartEncounter;

  const PatientCard({
    super.key,
    required this.patient,
    required this.onTap,
    this.onStartEncounter,
  });

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.paleJade,
                      child: Text(
                        patient.name.substring(0, 1),
                        style: AppTypography.cardTitle.copyWith(
                          color: AppColors.deepJade,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            patient.name,
                            style: AppTypography.cardTitle,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${patient.id} • ${patient.age}y • ${patient.gender}',
                            style: AppTypography.metadata,
                          ),
                        ],
                      ),
                    ),
                    CareSettingBadge(setting: patient.careSetting, compact: true),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.clinicalMist,
                    borderRadius: AppRadius.smBorder,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'Last Seen: ${patient.lastSeen}',
                          style: AppTypography.caption.copyWith(fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          '${patient.totalConsultations} Consultations',
                          textAlign: TextAlign.end,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.deepJade,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onStartEncounter != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onTap,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            minimumSize: const Size.fromHeight(38),
                            side: const BorderSide(color: AppColors.border),
                            shape: RoundedRectangleBorder(borderRadius: AppRadius.smBorder),
                          ),
                          child: Text(
                            'View Record',
                            style: AppTypography.metadata.copyWith(
                              color: AppColors.charcoal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onStartEncounter,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.deepJade,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            minimumSize: const Size.fromHeight(38),
                            shape: RoundedRectangleBorder(borderRadius: AppRadius.smBorder),
                          ),
                          child: Text(
                            'Start Encounter',
                            style: AppTypography.metadata.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
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

