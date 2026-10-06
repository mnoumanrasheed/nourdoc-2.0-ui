import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/brand_logo.dart';
import '../../shared/widgets/app_button.dart';
import '../../app/routes/app_routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Intelligent Clinical Listening',
      'subtitle':
          'Focus on your patient while NourDoc ambiently captures the clinical conversation with high precision.',
      'icon': Icons.mic_none_rounded,
      'badge': 'Ambient Capture',
    },
    {
      'title': 'Instant SOAP & Accurate Coding',
      'subtitle':
          'Generate structured SOAP notes and validated ICD-10 & CPT coding suggestions in seconds.',
      'icon': Icons.assignment_outlined,
      'badge': 'Automated Documentation',
    },
    {
      'title': 'Explainable Risk & Evidence Mapping',
      'subtitle':
          'Every AI conclusion is traceable to the exact moment in conversation, keeping you completely in control.',
      'icon': Icons.verified_user_outlined,
      'badge': 'Clinical Safety',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const NourDocLogo(height: 30),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.mainNav);
            },
            child: Text(
              'Skip',
              style: AppTypography.metadata.copyWith(
                color: AppColors.slate,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (idx) {
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    final item = _pages[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              color: AppColors.paleJade.withOpacity(0.4),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.deepJade.withOpacity(0.15),
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              item['icon'] as IconData,
                              size: 64,
                              color: AppColors.deepJade,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.paleJade,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              item['badge'] as String,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.deepJade,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            item['title'] as String,
                            textAlign: TextAlign.center,
                            style: AppTypography.pageTitle.copyWith(fontSize: 24),
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              item['subtitle'] as String,
                              textAlign: TextAlign.center,
                              style: AppTypography.body.copyWith(
                                color: AppColors.slate,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == i ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == i ? AppColors.deepJade : AppColors.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              AppButton(
                label: _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                onPressed: () {
                  if (_currentPage < _pages.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Navigator.of(context).pushNamed(AppRoutes.signIn);
                  }
                },
              ),
              const SizedBox(height: 12),
              AppButton(
                label: 'Sign In to Workspace',
                variant: ButtonVariant.outline,
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.signIn);
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

