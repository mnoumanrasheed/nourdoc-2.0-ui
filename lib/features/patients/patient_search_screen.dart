import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../models/mock/mock_models.dart';
import '../../shared/widgets/app_text_field.dart';
import '../../shared/widgets/patient_card.dart';
import '../../app/routes/app_routes.dart';

class PatientSearchScreen extends StatefulWidget {
  const PatientSearchScreen({super.key});

  @override
  State<PatientSearchScreen> createState() => _PatientSearchScreenState();
}

class _PatientSearchScreenState extends State<PatientSearchScreen> {
  final _searchController = TextEditingController();
  List<MockPatient> _results = MockData.patients;

  void _onSearch(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        _results = MockData.patients;
      } else {
        final q = query.toLowerCase();
        _results = MockData.patients.where((p) {
          return p.name.toLowerCase().contains(q) ||
              p.phone.contains(q) ||
              p.id.toLowerCase().contains(q) ||
              p.mrn.toLowerCase().contains(q);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Search Patients', style: AppTypography.cardTitle),
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
                hintText: 'Search by Name, Phone, MRN or ID...',
                prefixIcon: const Icon(Icons.search, color: AppColors.deepJade),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          _onSearch('');
                        },
                      )
                    : null,
                onChanged: _onSearch,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
                vertical: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_results.length} Patients Found',
                    style: AppTypography.label.copyWith(fontSize: 12),
                  ),
                  Text(
                    'Tap to view medical record',
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal),
                itemCount: _results.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final patient = _results[index];
                  return PatientCard(
                    patient: patient,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.patientProfile,
                        arguments: patient,
                      );
                    },
                    onStartEncounter: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.careSetting,
                        arguments: patient,
                      );
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

