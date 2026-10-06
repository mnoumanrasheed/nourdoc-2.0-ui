import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_typography.dart';

class AppAudioPlayer extends StatefulWidget {
  final String totalDuration;
  final ValueChanged<double>? onSeek;

  const AppAudioPlayer({
    super.key,
    this.totalDuration = '11:45',
    this.onSeek,
  });

  @override
  State<AppAudioPlayer> createState() => _AppAudioPlayerState();
}

class _AppAudioPlayerState extends State<AppAudioPlayer> {
  bool _isPlaying = false;
  double _currentSeconds = 102.0; // 01:42
  final double _maxSeconds = 705.0; // 11:45

  String _formatTime(double seconds) {
    final mins = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds.toInt() % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.paleJade.withOpacity(0.4),
        borderRadius: AppRadius.mdBorder,
        border: Border.all(color: AppColors.deepJade.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _isPlaying = !_isPlaying;
                  });
                },
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.deepJade,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _formatTime(_currentSeconds),
                style: AppTypography.metadata.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepJade,
                ),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.deepJade,
                    inactiveTrackColor: AppColors.deepJade.withOpacity(0.18),
                    thumbColor: AppColors.deepJade,
                    trackHeight: 3.5,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
                  ),
                  child: Slider(
                    value: _currentSeconds,
                    min: 0.0,
                    max: _maxSeconds,
                    onChanged: (val) {
                      setState(() {
                        _currentSeconds = val;
                      });
                      widget.onSeek?.call(val);
                    },
                  ),
                ),
              ),
              Text(
                widget.totalDuration,
                style: AppTypography.metadata.copyWith(
                  color: AppColors.slate,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

