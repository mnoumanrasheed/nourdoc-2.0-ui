import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class OrganicWaveform extends StatefulWidget {
  final bool isRecording;
  final bool isProcessing;
  final double size;

  const OrganicWaveform({
    super.key,
    this.isRecording = true,
    this.isProcessing = false,
    this.size = 220,
  });

  @override
  State<OrganicWaveform> createState() => _OrganicWaveformState();
}

class _OrganicWaveformState extends State<OrganicWaveform>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _WaveformPainter(
            animationValue: _controller.value,
            isRecording: widget.isRecording,
            isProcessing: widget.isProcessing,
          ),
        );
      },
    );
  }
}

class _WaveformPainter extends CustomPainter {
  final double animationValue;
  final bool isRecording;
  final bool isProcessing;

  _WaveformPainter({
    required this.animationValue,
    required this.isRecording,
    required this.isProcessing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = size.width * 0.28;

    // Draw pulsing rings
    for (int i = 1; i <= 3; i++) {
      final progress = (animationValue + (i * 0.33)) % 1.0;
      final ringRadius = baseRadius + (progress * size.width * 0.22);
      final opacity = ((1.0 - progress) * 0.35).clamp(0.0, 1.0);

      final ringPaint = Paint()
        ..color = isProcessing
            ? AppColors.clinicalBlue.withOpacity(opacity)
            : AppColors.deepJade.withOpacity(opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      canvas.drawCircle(center, ringRadius, ringPaint);
    }

    // Draw organic node connections (circuit-tree / neural motif)
    final nodePaint = Paint()
      ..color = AppColors.freshJade.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    const nodeCount = 8;
    for (int i = 0; i < nodeCount; i++) {
      final angle = (i * (2 * math.pi / nodeCount)) + (animationValue * 0.5);
      final dist = baseRadius + 14 * math.sin(animationValue * 2 * math.pi + i);
      final nodePos = Offset(
        center.dx + dist * math.cos(angle),
        center.dy + dist * math.sin(angle),
      );

      // Line to center
      canvas.drawLine(center, nodePos, nodePaint);

      // Node dot
      final dotPaint = Paint()
        ..color = i % 2 == 0 ? AppColors.deepJade : AppColors.freshJade
        ..style = PaintingStyle.fill;
      canvas.drawCircle(nodePos, 3.5, dotPaint);
    }

    // Central core glowing circle
    final coreGradient = RadialGradient(
      colors: isProcessing
          ? [AppColors.clinicalBlue, AppColors.deepJade]
          : [AppColors.freshJade, AppColors.deepJade],
    );

    final corePaint = Paint()
      ..shader = coreGradient.createShader(
        Rect.fromCircle(center: center, radius: baseRadius),
      )
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, baseRadius, corePaint);

    // Inner subtle glow
    final innerPulse = 1.0 + (0.06 * math.sin(animationValue * 2 * math.pi));
    final glowPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(center, baseRadius * 0.85 * innerPulse, glowPaint);
  }

  @override
  bool shouldRepaint(covariant _WaveformPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.isRecording != isRecording ||
        oldDelegate.isProcessing != isProcessing;
  }
}

