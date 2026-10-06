import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/nourdoc_error_state.dart';

class ErrorStatesScreen extends StatefulWidget {
  const ErrorStatesScreen({super.key});

  @override
  State<ErrorStatesScreen> createState() => _ErrorStatesScreenState();
}

class _ErrorStatesScreenState extends State<ErrorStatesScreen> {
  int _selectedType = 0;

  final List<Map<String, String>> _errorTypes = [
    {
      'name': 'No Connection',
      'title': 'Clinical Sync Disconnected',
      'message': 'Unable to reach the secure medical processing servers. Ambient recordings are safely saved offline.',
    },
    {
      'name': 'Audio Failed',
      'title': 'Microphone Stream Interrupted',
      'message': 'The ambient audio capture device was disconnected. Please check audio permissions.',
    },
    {
      'name': 'Gateway Error',
      'title': 'Payment Processing Unavailable',
      'message': 'The billing payment provider timed out while confirming credentials. Please retry.',
    },
    {
      'name': 'Corrupt File',
      'title': 'EHR Record Unavailable',
      'message': 'The selected clinical consultation archive could not be parsed into FHIR format.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final cur = _errorTypes[_selectedType];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Standardized Error States', style: AppTypography.cardTitle),
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
                  children: List.generate(_errorTypes.length, (idx) {
                    final isSel = _selectedType == idx;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(_errorTypes[idx]['name']!),
                        selected: isSel,
                        selectedColor: AppColors.rose,
                        labelStyle: AppTypography.caption.copyWith(
                          color: isSel ? Colors.white : AppColors.charcoal,
                          fontWeight: FontWeight.w600,
                        ),
                        backgroundColor: AppColors.clinicalMist,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.smBorder,
                          side: BorderSide(color: isSel ? AppColors.rose : AppColors.border),
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
                child: NourDocErrorState(
                  title: cur['title']!,
                  message: cur['message']!,
                  onRetry: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Retrying operation for: ${cur['name']}')),
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

