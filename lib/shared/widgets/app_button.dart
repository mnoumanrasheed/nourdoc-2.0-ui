import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_typography.dart';

enum ButtonVariant { primary, secondary, outline, text, destructive }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final double? width;
  final double height;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    Color getBgColor() {
      switch (variant) {
        case ButtonVariant.primary:
          return AppColors.deepJade;
        case ButtonVariant.secondary:
          return AppColors.paleJade;
        case ButtonVariant.outline:
          return Colors.white;
        case ButtonVariant.text:
          return Colors.transparent;
        case ButtonVariant.destructive:
          return AppColors.rose;
      }
    }

    Color getTextColor() {
      switch (variant) {
        case ButtonVariant.primary:
          return Colors.white;
        case ButtonVariant.secondary:
          return AppColors.deepJade;
        case ButtonVariant.outline:
          return AppColors.deepJade;
        case ButtonVariant.text:
          return AppColors.deepJade;
        case ButtonVariant.destructive:
          return Colors.white;
      }
    }

    BorderSide? getBorder() {
      if (variant == ButtonVariant.outline) {
        return const BorderSide(color: AppColors.deepJade, width: 1.5);
      }
      return null;
    }

    final effectiveBg = onPressed == null ? Colors.grey.shade300 : getBgColor();
    final effectiveText = onPressed == null ? Colors.grey.shade600 : getTextColor();

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: Material(
        color: effectiveBg,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.mdBorder,
          side: getBorder() ?? BorderSide.none,
        ),
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: AppRadius.mdBorder,
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      color: effectiveText,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, size: 18, color: effectiveText),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Text(
                          label,
                          style: AppTypography.button.copyWith(color: effectiveText),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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

