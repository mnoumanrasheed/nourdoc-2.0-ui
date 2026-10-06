import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/nourdoc_empty_state.dart';

class EmptyStatesScreen extends StatefulWidget {
  const EmptyStatesScreen({super.key});

  @override
  State<EmptyStatesScreen> createState() => _EmptyStatesScreenState();
}

class _EmptyStatesScreenState extends State<EmptyStatesScreen> {
  int _selectedType = 0;

  final List<Map<String, dynamic>> _emptyTypes = [
    {
      'name': 'No Patients',
      'title': 'No Patients Registered Yet',
      'message': 'Create your first clinical patient intake or sync with your hospital EHR directory.',
      'icon': Icons.people_outline,
      'cta': 'Register New Patient',
    },
    {
      'name': 'No Consultations',
      'title': 'No Encounters Recorded Today',
      'message': 'Start an ambient recording session to capture your first clinical consultation.',
      'icon': Icons.mic_none_outlined,
      'cta': 'Start Encounter',
    },
    {
      'name': 'No Risk Signals',
      'title': 'No Clinical Risk Signals Flagged',
      'message': 'AI analysis detected no high-risk drug interactions or unaddressed critical concerns.',
      'icon': Icons.shield_outlined,
      'cta': 'View Full Documentation',
    },
    {
      'name': 'No Evidence',
      'title': 'No Traceable Evidence Quotes',
      'message': 'Clinical evidence quotes will appear here once audio analysis completes.',
      'icon': Icons.search_outlined,
      'cta': 'Refresh Analysis',
    },
    {
      'name': 'No Invoices',
      'title': 'No Billing Invoices Found',
      'message': 'Invoices and tax receipts will appear here after your first subscription renewal.',
      'icon': Icons.receipt_long_outlined,
      'cta': 'View Plans',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final current = _emptyTypes[_selectedType];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Standardized Empty States', style: AppTypography.cardTitle),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal, vertical: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(_emptyTypes.length, (idx) {
                    final isSel = _selectedType == idx;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(_emptyTypes[idx]['name']),
                        selected: isSel,
                        selectedColor: AppColors.deepJade,
                        labelStyle: AppTypography.caption.copyWith(
                          color: isSel ? Colors.white : AppColors.charcoal,
                          fontWeight: FontWeight.w600,
                        ),
                        backgroundColor: AppColors.clinicalMist,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.smBorder,
                          side: BorderSide(color: isSel ? AppColors.deepJade : AppColors.border),
                        ),
                        onSelected: (val) {
                          if (val) setState(() => _selectedType = idx);
                        },
                      ),
                    );
                  }),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: NourDocEmptyState(
                  title: current['title'],
                  message: current['message'],
                  icon: current['icon'],
                  actionLabel: current['cta'],
                  onAction: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Triggered action for: ${current['name']}')),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

