import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/organic_waveform.dart';
import '../../app/routes/app_routes.dart';

class AiProcessingScreen extends StatefulWidget {
  const AiProcessingScreen({super.key});

  @override
  State<AiProcessingScreen> createState() => _AiProcessingScreenState();
}

class _AiProcessingScreenState extends State<AiProcessingScreen> {
  int _activeStage = 0;
  Timer? _timer;

  final List<String> _stages = [
    'Conversation captured & verified',
    'Audio processed & speaker separated',
    'Clinical information extracted',
    'SOAP note generated',
    'ICD-10 & CPT coding suggestions prepared',
    'Traceable clinical evidence identified',
    'Clinical risk & safety review prepared',
  ];

  @override
  void initState() {
    super.initState();
    _startStagedProcessing();
  }

  void _startStagedProcessing() {
    _timer = Timer.periodic(const Duration(milliseconds: 700), (timer) {
      if (mounted) {
        if (_activeStage < _stages.length - 1) {
          setState(() => _activeStage++);
        } else {
          _timer?.cancel();
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDone = _activeStage >= _stages.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Clinical Intelligence Engine', style: AppTypography.cardTitle),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 16,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Organic Circuit / Waveform animation
              OrganicWaveform(
                isRecording: false,
                isProcessing: true,
                size: 160,
              ),
              const SizedBox(height: 20),

              Text(
                'NourDoc is preparing your clinical report',
                textAlign: TextAlign.center,
                style: AppTypography.pageTitle.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 6),
              Text(
                'Synthesizing clinical evidence, diagnostic reasoning, and medical coding.',
                textAlign: TextAlign.center,
                style: AppTypography.body.copyWith(color: AppColors.slate, fontSize: 13),
              ),
              const SizedBox(height: 20),

              // Multi-step clinical pipeline
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _stages.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final isComplete = index < _activeStage || isDone;
                    final isCurrent = index == _activeStage && !isDone;

                    Widget leadingIcon;

                    if (isComplete) {
                      leadingIcon = const Icon(Icons.check_circle, size: 20, color: AppColors.deepJade);
                    } else if (isCurrent) {
                      leadingIcon = const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.clinicalBlue,
                        ),
                      );
                    } else {
                      leadingIcon = Icon(Icons.radio_button_unchecked, size: 20, color: Colors.grey.shade400);
                    }

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: isCurrent
                            ? AppColors.paleJade.withOpacity(0.5)
                            : (isComplete ? AppColors.clinicalMist : Colors.white),
                        borderRadius: AppRadius.smBorder,
                        border: Border.all(
                          color: isCurrent
                              ? AppColors.deepJade.withOpacity(0.4)
                              : (isComplete ? AppColors.borderLight : AppColors.border),
                        ),
                      ),
                      child: Row(
                        children: [
                          leadingIcon,
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _stages[index],
                              style: AppTypography.bodyMedium.copyWith(
                                fontSize: 13,
                                color: isComplete
                                    ? AppColors.charcoal
                                    : (isCurrent ? AppColors.deepJade : AppColors.slateLight),
                                fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              AppButton(
                label: isDone ? 'Open Clinical Report' : 'Preparing Report...',
                isLoading: !isDone,
                icon: isDone ? Icons.arrow_forward : null,
                onPressed: isDone
                    ? () {
                        Navigator.of(context).pushReplacementNamed(AppRoutes.reportOverview);
                      }
                    : null,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
