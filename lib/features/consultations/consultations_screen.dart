import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../models/mock/mock_models.dart';
import '../../shared/widgets/app_text_field.dart';
import '../../shared/widgets/encounter_card.dart';
import '../../app/routes/app_routes.dart';

class ConsultationsScreen extends StatefulWidget {
  const ConsultationsScreen({super.key});

  @override
  State<ConsultationsScreen> createState() => _ConsultationsScreenState();
}

class _ConsultationsScreenState extends State<ConsultationsScreen> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Today', 'Ready', 'Processing', 'Delayed'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<MockConsultation> list = MockData.consultations;

    // Apply filter
    if (_selectedFilter == 'Today') {
      list = list.where((c) => c.dateTime.contains('Today')).toList();
    } else if (_selectedFilter == 'Ready') {
      list = list.where((c) => c.status == ConsultationStatus.ready).toList();
    } else if (_selectedFilter == 'Processing') {
      list = list.where((c) => c.status == ConsultationStatus.processing).toList();
    } else if (_selectedFilter == 'Delayed') {
      list = list.where((c) => c.status == ConsultationStatus.delayed).toList();
    }

    if (_searchController.text.isNotEmpty) {
      final q = _searchController.text.toLowerCase();
      list = list.where((c) => c.patientName.toLowerCase().contains(q) || c.primaryDiagnosis.toLowerCase().contains(q)).toList();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Consultations', style: AppTypography.cardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: AppColors.deepJade),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.selectPatient);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
                vertical: 12,
              ),
              child: AppTextField(
                controller: _searchController,
                hintText: 'Search consultations by patient or diagnosis...',
                prefixIcon: const Icon(Icons.search, color: AppColors.deepJade),
                onChanged: (v) => setState(() {}),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: AppSpacing.screenHorizontal, bottom: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _filters.map((filter) {
                    final isSel = _selectedFilter == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(filter),
                        selected: isSel,
                        selectedColor: AppColors.deepJade,
                        labelStyle: AppTypography.caption.copyWith(
                          color: isSel ? Colors.white : AppColors.charcoal,
                          fontWeight: FontWeight.w600,
                        ),
                        backgroundColor: AppColors.clinicalMist,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.smBorder,
                          side: BorderSide(
                            color: isSel ? AppColors.deepJade : AppColors.border,
                          ),
                        ),
                        onSelected: (val) {
                          if (val) setState(() => _selectedFilter = filter);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${list.length} Clinical Records', style: AppTypography.label),
                  Text('Filtered by $_selectedFilter', style: AppTypography.caption),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal),
                itemCount: list.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final c = list[index];
                  return EncounterCard(
                    consultation: c,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.consultationDetail, arguments: c);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

