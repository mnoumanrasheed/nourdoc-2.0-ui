import 'package:flutter/material.dart';
import '../../core/assets/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class NourDocLogo extends StatelessWidget {
  final double height;
  final bool showText;
  final Color? textColor;

  const NourDocLogo({
    super.key,
    this.height = 36,
    this.showText = true,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          AppAssets.logo,
          height: height,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: height,
              width: height,
              decoration: BoxDecoration(
                color: AppColors.paleJade,
                borderRadius: BorderRadius.circular(height * 0.25),
                border: Border.all(color: AppColors.deepJade, width: 1.5),
              ),
              child: Icon(
                Icons.medical_services_rounded,
                color: AppColors.deepJade,
                size: height * 0.55,
              ),
            );
          },
        ),
        if (showText) ...[
          const SizedBox(width: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Nour',
                  style: AppTypography.pageTitle.copyWith(
                    fontSize: height * 0.55,
                    fontWeight: FontWeight.w800,
                    color: textColor ?? AppColors.charcoal,
                    letterSpacing: -0.5,
                  ),
                ),
                TextSpan(
                  text: 'Doc',
                  style: AppTypography.pageTitle.copyWith(
                    fontSize: height * 0.55,
                    fontWeight: FontWeight.w800,
                    color: AppColors.deepJade,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

