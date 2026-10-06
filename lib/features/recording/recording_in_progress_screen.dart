import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../models/mock/mock_models.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/clinical_badges.dart';
import '../../shared/widgets/organic_waveform.dart';
import '../../app/routes/app_routes.dart';

class RecordingInProgressScreen extends StatefulWidget {
  const RecordingInProgressScreen({super.key});

  @override
  State<RecordingInProgressScreen> createState() => _RecordingInProgressScreenState();
}

class _RecordingInProgressScreenState extends State<RecordingInProgressScreen> {
  int _seconds = 222; // 03:42
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() => _seconds++);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTimer(int totalSeconds) {
    final m = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _showDiscardDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Discard Encounter?', style: AppTypography.cardTitle),
        content: Text(
          'Are you sure you want to discard this clinical recording? Audio and notes captured so far will be lost.',
          style: AppTypography.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Keep Recording'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.rose),
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.mainNav, (r) => false);
            },
            child: const Text('Discard', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final patient = MockData.patients.first;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Clinical Encounter', style: AppTypography.cardTitle),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.rose),
            onPressed: _showDiscardDialog,
            tooltip: 'Discard',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 16,
          ),
          child: Column(
            children: [
              // Patient Banner
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.clinicalMist,
                  borderRadius: AppRadius.mdBorder,
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(patient.name, style: AppTypography.cardTitle.copyWith(fontSize: 15)),
                        const SizedBox(height: 2),
                        Text('${patient.age}y ${patient.gender} • Follow-up Visit', style: AppTypography.caption),
                      ],
                    ),
                    CareSettingBadge(setting: CareSetting.opd, compact: true),
                  ],
                ),
              ),
              const Spacer(),

              // "NourDoc is listening" Pulse
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: AppColors.rose,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'NourDoc is listening',
                    style: AppTypography.metadata.copyWith(
                      color: AppColors.charcoal,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Animated Waveform
              const OrganicWaveform(isRecording: true, size: 220),
              const SizedBox(height: 32),

              // Recording Timer
              Text(
                _formatTimer(_seconds),
                style: AppTypography.pageTitle.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Ambient clinical audio capture in progress',
                style: AppTypography.caption.copyWith(color: AppColors.slate),
              ),

              const Spacer(),

              // Secondary actions: Pause & Resume
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      _timer?.cancel();
                      Navigator.of(context).pushReplacementNamed(AppRoutes.recordingPaused);
                    },
                    icon: const Icon(Icons.pause, size: 18),
                    label: const Text('Pause Recording'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.charcoal,
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(borderRadius: AppRadius.smBorder),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Dominant CTA: Finish Consultation
              AppButton(
                label: 'Finish Consultation',
                icon: Icons.check_circle_outline,
                onPressed: () {
                  _timer?.cancel();
                  Navigator.of(context).pushReplacementNamed(AppRoutes.consultationSubmitted);
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

