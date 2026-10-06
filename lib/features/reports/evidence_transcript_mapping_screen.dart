import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/app_audio_player.dart';

class EvidenceTranscriptMappingScreen extends StatefulWidget {
  final dynamic arguments;

  const EvidenceTranscriptMappingScreen({super.key, this.arguments});

  @override
  State<EvidenceTranscriptMappingScreen> createState() => _EvidenceTranscriptMappingScreenState();
}

class _EvidenceTranscriptMappingScreenState extends State<EvidenceTranscriptMappingScreen> {
  String _activeTimestamp = '01:42';

  final List<Map<String, String>> _transcriptRows = [
    {
      'speaker': 'Dr. Nouman',
      'role': 'Clinician',
      'time': '00:15',
      'text': 'Good morning, Sarah. I see you are returning to discuss your cough. How has it been over the last few weeks?',
    },
    {
      'speaker': 'Sarah Jenkins',
      'role': 'Patient',
      'time': '01:42',
      'text': 'The cough has been going on for about three weeks now, usually worse when I lie down at night.',
    },
    {
      'speaker': 'Dr. Nouman',
      'role': 'Clinician',
      'time': '02:30',
      'text': 'Have you noticed any shortness of breath or fever along with it?',
    },
    {
      'speaker': 'Sarah Jenkins',
      'role': 'Patient',
      'time': '03:15',
      'text': 'I tried cough syrup from the pharmacy but it didn\'t really do anything for the tightness in my chest.',
    },
    {
      'speaker': 'Dr. Nouman',
      'role': 'Clinician',
      'time': '05:28',
      'text': 'Let me listen to your lungs now. Take a deep breath in through your mouth... There is mild expiratory wheezing in the right lung.',
    },
  ];

  @override
  void initState() {
    super.initState();
    if (widget.arguments is Map && widget.arguments['activeTimestamp'] != null) {
      _activeTimestamp = widget.arguments['activeTimestamp'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Evidence ↔ Transcript Mapping', style: AppTypography.cardTitle),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top audio bar
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Anchored to Audio At: $_activeTimestamp', style: AppTypography.metadata.copyWith(color: AppColors.deepJade, fontWeight: FontWeight.w700)),
                      Text('Synched', style: AppTypography.caption.copyWith(color: AppColors.deepJade)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const AppAudioPlayer(totalDuration: '11:45'),
                ],
              ),
            ),

            // Transcript rows
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
                itemCount: _transcriptRows.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final row = _transcriptRows[index];
                  final isTarget = row['time'] == _activeTimestamp;
                  final isDoctor = row['role'] == 'Clinician';

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isTarget ? AppColors.paleJade.withOpacity(0.4) : Colors.white,
                      borderRadius: AppRadius.mdBorder,
                      border: Border.all(
                        color: isTarget ? AppColors.deepJade : AppColors.border,
                        width: isTarget ? 1.8 : 1.0,
                      ),
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
                                    isDoctor ? 'Dr' : 'Pt',
                                    style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${row['speaker']} (${row['role']})',
                                  style: AppTypography.cardTitle.copyWith(fontSize: 13),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                setState(() => _activeTimestamp = row['time']!);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isTarget ? AppColors.deepJade : AppColors.clinicalMist,
                                  borderRadius: AppRadius.xsBorder,
                                ),
                                child: Text(
                                  row['time']!,
                                  style: AppTypography.caption.copyWith(
                                    color: isTarget ? Colors.white : AppColors.slate,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          row['text']!,
                          style: AppTypography.body.copyWith(
                            fontSize: 13,
                            color: isTarget ? AppColors.charcoal : AppColors.slate,
                            fontWeight: isTarget ? FontWeight.w600 : FontWeight.w400,
                          ),
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
