import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_models.dart';
import '../../shared/widgets/app_audio_player.dart';

class PatientReportTranscriptScreen extends StatefulWidget {
  final MockConsultation? consultation;

  const PatientReportTranscriptScreen({super.key, this.consultation});

  @override
  State<PatientReportTranscriptScreen> createState() => _PatientReportTranscriptScreenState();
}

class _PatientReportTranscriptScreenState extends State<PatientReportTranscriptScreen> {
  final List<Map<String, String>> _transcript = [
    {
      'speaker': 'Dr. Nouman',
      'role': 'Clinician',
      'time': '00:04',
      'text': 'Good morning, Sarah. Please take a seat. How have you been feeling since our last visit?',
    },
    {
      'speaker': 'Sarah Jenkins',
      'role': 'Patient',
      'time': '00:22',
      'text': 'Good morning, Doctor. Honestly, the cough has been really persistent. It has been almost three weeks now.',
    },
    {
      'speaker': 'Dr. Nouman',
      'role': 'Clinician',
      'time': '00:45',
      'text': 'Is it dry or are you coughing up any phlegm or blood?',
    },
    {
      'speaker': 'Sarah Jenkins',
      'role': 'Patient',
      'time': '01:05',
      'text': 'No phlegm or blood, strictly dry. It gets noticeably worse at night when I lay down in bed.',
    },
    {
      'speaker': 'Dr. Nouman',
      'role': 'Clinician',
      'time': '01:40',
      'text': 'Any fever, chills, or difficulty catching your breath when walking upstairs?',
    },
    {
      'speaker': 'Sarah Jenkins',
      'role': 'Patient',
      'time': '02:05',
      'text': 'Mild chest tightness, but no fever. I bought over the counter cough syrup but it barely helped.',
    },
    {
      'speaker': 'Dr. Nouman',
      'role': 'Clinician',
      'time': '03:10',
      'text': 'Alright. Let us proceed with chest auscultation. Breathe in deeply... Good. A faint expiratory wheeze in the right middle zone.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Verbatim Encounter Transcript', style: AppTypography.cardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
            tooltip: 'Search Transcript',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Sticky audio controller
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal, vertical: 10),
              child: const AppAudioPlayer(totalDuration: '11:45'),
            ),

            // Transcript timeline list
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
                itemCount: _transcript.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final entry = _transcript[index];
                  final isDoctor = entry['role'] == 'Clinician';

                  return Container(
                    padding: const EdgeInsets.all(14),
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
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: isDoctor ? AppColors.deepJade : AppColors.clinicalBlue,
                                  child: Text(
                                    isDoctor ? 'D' : 'P',
                                    style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${entry['speaker']} (${entry['role']})',
                                  style: AppTypography.cardTitle.copyWith(
                                    fontSize: 13,
                                    color: isDoctor ? AppColors.deepJade : AppColors.charcoal,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.clinicalMist,
                                borderRadius: AppRadius.xsBorder,
                              ),
                              child: Text(
                                entry['time']!,
                                style: AppTypography.caption.copyWith(color: AppColors.slate, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          entry['text']!,
                          style: AppTypography.body.copyWith(fontSize: 13.5, height: 1.45),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
