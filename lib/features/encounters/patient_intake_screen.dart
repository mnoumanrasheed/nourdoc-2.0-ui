import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_models.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_text_field.dart';
import '../../app/routes/app_routes.dart';

class PatientIntakeScreen extends StatefulWidget {
  final Map<String, dynamic>? initialData;

  const PatientIntakeScreen({super.key, this.initialData});

  @override
  State<PatientIntakeScreen> createState() => _PatientIntakeScreenState();
}

class _PatientIntakeScreenState extends State<PatientIntakeScreen> {
  final _nameController = TextEditingController(text: 'Sarah Jenkins');
  final _phoneController = TextEditingController(text: '+1 (555) 234-8901');
  final _ageController = TextEditingController(text: '42');
  final _genderController = TextEditingController(text: 'Female');
  final _tempController = TextEditingController(text: '98.8');
  final _pulseController = TextEditingController(text: '78');
  final _respController = TextEditingController(text: '18');
  final _bpController = TextEditingController(text: '124/82');
  final _bsController = TextEditingController(text: '108');

  String _visitType = 'Follow-up';
  CareSetting _careSetting = CareSetting.opd;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      final p = widget.initialData!['patient'] as MockPatient?;
      final s = widget.initialData!['setting'] as CareSetting?;
      if (p != null) {
        _nameController.text = p.name;
        _phoneController.text = p.phone;
        _ageController.text = p.age.toString();
        _genderController.text = p.gender;
        _tempController.text = p.vitals.temperature.replaceAll(' °F', '');
        _pulseController.text = p.vitals.pulse.replaceAll(' bpm', '');
        _respController.text = p.vitals.respiration.replaceAll(' /min', '');
        _bpController.text = p.vitals.bloodPressure.replaceAll(' mmHg', '');
        _bsController.text = p.vitals.bloodSugar.replaceAll(' mg/dL', '');
      }
      if (s != null) {
        _careSetting = s;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _tempController.dispose();
    _pulseController.dispose();
    _respController.dispose();
    _bpController.dispose();
    _bsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Clinical Intake & Vitals', style: AppTypography.cardTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Demographics Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.mdBorder,
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Patient Demographics', style: AppTypography.cardTitle.copyWith(fontSize: 15)),
                    const SizedBox(height: 14),
                    AppTextField(label: 'Full Name', controller: _nameController),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: AppTextField(label: 'Age (Years)', controller: _ageController, keyboardType: TextInputType.number)),
                        const SizedBox(width: 12),
                        Expanded(child: AppTextField(label: 'Gender', controller: _genderController)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    AppTextField(label: 'Phone Number', controller: _phoneController, keyboardType: TextInputType.phone),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Visit Type Segment
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.mdBorder,
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Visit Classification', style: AppTypography.cardTitle.copyWith(fontSize: 15)),
                    const SizedBox(height: 12),
                    Row(
                      children: ['New Patient', 'Follow-up', 'Emergency'].map((type) {
                        final isSel = _visitType == type;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: InkWell(
                              onTap: () => setState(() => _visitType = type),
                              borderRadius: AppRadius.smBorder,
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: isSel ? AppColors.paleJade : AppColors.clinicalMist,
                                  borderRadius: AppRadius.smBorder,
                                  border: Border.all(
                                    color: isSel ? AppColors.deepJade : AppColors.border,
                                    width: isSel ? 1.5 : 1.0,
                                  ),
                                ),
                                child: Text(
                                  type,
                                  textAlign: TextAlign.center,
                                  style: AppTypography.caption.copyWith(
                                    fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                                    color: isSel ? AppColors.deepJade : AppColors.charcoal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Objective Vital Signs Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.mdBorder,
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Triage Vitals (Pre-recording)',
                            style: AppTypography.cardTitle.copyWith(fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.paleJade,
                            borderRadius: AppRadius.xsBorder,
                          ),
                          child: Text(
                            '${_careSetting.label} Intake',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.deepJade,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(child: AppTextField(label: 'BP (mmHg)', controller: _bpController)),
                        const SizedBox(width: 12),
                        Expanded(child: AppTextField(label: 'Heart Rate (bpm)', controller: _pulseController)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: AppTextField(label: 'Temp (°F)', controller: _tempController)),
                        const SizedBox(width: 12),
                        Expanded(child: AppTextField(label: 'Resp (/min)', controller: _respController)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    AppTextField(label: 'Random Blood Sugar (mg/dL)', controller: _bsController),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              AppButton(
                label: 'Confirm Context & Begin Encounter',
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.clinicalContext);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
