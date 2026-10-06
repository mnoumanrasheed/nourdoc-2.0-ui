import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import 'app_button.dart';

class NourDocErrorState extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRetry;

  const NourDocErrorState({
    super.key,
    this.title = 'Unable to Load Content',
    this.message = 'A clinical synchronization or connection error occurred. Please try again.',
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: AppColors.roseLight,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.rose.withOpacity(0.3), width: 1.5),
              ),
              child: const Icon(Icons.error_outline_rounded, size: 36, color: AppColors.rose),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypography.sectionTitle.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTypography.body.copyWith(color: AppColors.slate, fontSize: 13),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 22),
              SizedBox(
                width: 160,
                child: AppButton(
                  label: 'Try Again',
                  onPressed: onRetry,
                  variant: ButtonVariant.primary,
                  height: 40,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

