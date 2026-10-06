import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../app/routes/app_routes.dart';

class PreviousReportsScreen extends StatelessWidget {
  const PreviousReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final consultations = MockData.consultations;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Historical Clinical Reports', style: AppTypography.cardTitle),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 16,
          ),
          itemCount: consultations.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final c = consultations[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppRadius.mdBorder,
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        c.patientName,
                        style: AppTypography.cardTitle.copyWith(fontSize: 16),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.paleJade,
                          borderRadius: AppRadius.xsBorder,
                        ),
                        child: Text(
                          c.id,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.deepJade,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    c.primaryDiagnosis,
                    style: AppTypography.body.copyWith(color: AppColors.slate, fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.slate),
                          const SizedBox(width: 4),
                          Text('${c.dateTime} (${c.duration})', style: AppTypography.caption),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.reportOverview, arguments: c);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.deepJade,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          minimumSize: const Size(0, 32),
                          shape: RoundedRectangleBorder(borderRadius: AppRadius.smBorder),
                        ),
                        child: Text('View SOAP & Coding', style: AppTypography.caption.copyWith(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

