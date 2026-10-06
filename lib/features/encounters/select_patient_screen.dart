import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../models/mock/mock_models.dart';
import '../../shared/widgets/app_text_field.dart';
import '../../shared/widgets/patient_card.dart';
import '../../app/routes/app_routes.dart';

class SelectPatientScreen extends StatefulWidget {
  const SelectPatientScreen({super.key});

  @override
  State<SelectPatientScreen> createState() => _SelectPatientScreenState();
}

class _SelectPatientScreenState extends State<SelectPatientScreen> {
  final _searchController = TextEditingController();
  List<MockPatient> _list = MockData.patients;

  void _filter(String query) {
    setState(() {
      if (query.isEmpty) {
        _list = MockData.patients;
      } else {
        final q = query.toLowerCase();
        _list = MockData.patients.where((p) => p.name.toLowerCase().contains(q) || p.mrn.toLowerCase().contains(q)).toList();
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
        title: Text('New Encounter — Select Patient', style: AppTypography.cardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt_1_outlined),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.patientIntake);
            },
            tooltip: 'New Patient Intake',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal, vertical: 12),
              child: AppTextField(
                controller: _searchController,
                hintText: 'Search patient by name or MRN...',
                prefixIcon: const Icon(Icons.search, color: AppColors.deepJade),
                onChanged: _filter,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Active Patients (${_list.length})',
                      style: AppTypography.label,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.patientIntake);
                    },
                    icon: const Icon(Icons.add, size: 16, color: AppColors.deepJade),
                    label: Text(
                      'Quick Intake',
                      style: AppTypography.metadata.copyWith(
                        color: AppColors.deepJade,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal),
                itemCount: _list.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final patient = _list[index];
                  return PatientCard(
                    patient: patient,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.careSetting, arguments: patient);
                    },
                    onStartEncounter: () {
                      Navigator.of(context).pushNamed(AppRoutes.careSetting, arguments: patient);
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
