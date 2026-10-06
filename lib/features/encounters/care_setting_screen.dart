import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../models/mock/mock_models.dart';
import '../../shared/widgets/app_button.dart';
import '../../app/routes/app_routes.dart';

class CareSettingScreen extends StatefulWidget {
  final MockPatient? patient;

  const CareSettingScreen({super.key, this.patient});

  @override
  State<CareSettingScreen> createState() => _CareSettingScreenState();
}

class _CareSettingScreenState extends State<CareSettingScreen> {
  late MockPatient _patient;
  CareSetting _selectedSetting = CareSetting.opd;

  @override
  void initState() {
    super.initState();
    _patient = widget.patient ?? MockData.patients.first;
    _selectedSetting = _patient.careSetting;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Care Setting', style: AppTypography.cardTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Patient Banner
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.mdBorder,
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.paleJade,
                      child: Text(
                        _patient.name.substring(0, 1),
                        style: AppTypography.cardTitle.copyWith(color: AppColors.deepJade),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_patient.name, style: AppTypography.cardTitle.copyWith(fontSize: 15)),
                          Text('${_patient.mrn} • ${_patient.age}y ${_patient.gender}', style: AppTypography.caption),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'Where is this patient being seen?',
                style: AppTypography.sectionTitle.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 8),
              Text(
                'Select the operational clinical environment to configure AI clinical context and coding priorities.',
                style: AppTypography.body.copyWith(color: AppColors.slate),
              ),
              const SizedBox(height: 24),

              // Care setting options
              Expanded(
                child: ListView(
                  children: [
                    _buildOption(
                      setting: CareSetting.opd,
                      title: 'OPD (Outpatient Department)',
                      description: 'Ambulatory clinic, scheduled follow-ups, and outpatient evaluations.',
                      color: AppColors.opd,
                      icon: Icons.local_hospital_outlined,
                    ),
                    const SizedBox(height: 12),
                    _buildOption(
                      setting: CareSetting.emergency,
                      title: 'Emergency (ER / Trauma)',
                      description: 'Urgent triage, acute stabilization, rapid resuscitation workflows.',
                      color: AppColors.emergency,
                      icon: Icons.emergency_outlined,
                    ),
                    const SizedBox(height: 12),
                    _buildOption(
                      setting: CareSetting.ipd,
                      title: 'IPD (Inpatient Department)',
                      description: 'Ward rounds, admitted patient tracking, multi-day progress notes.',
                      color: AppColors.ipd,
                      icon: Icons.hotel_outlined,
                    ),
                    const SizedBox(height: 12),
                    _buildOption(
                      setting: CareSetting.ot,
                      title: 'OT (Operating Theatre)',
                      description: 'Intraoperative notes, surgical safety checklist, pre/post-op records.',
                      color: AppColors.ot,
                      icon: Icons.medical_services_outlined,
                    ),
                  ],
                ),
              ),

              AppButton(
                label: 'Continue to Patient Intake',
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.patientIntake,
                    arguments: {
                      'patient': _patient,
                      'setting': _selectedSetting,
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption({
    required CareSetting setting,
    required String title,
    required String description,
    required Color color,
    required IconData icon,
  }) {
    final isSelected = _selectedSetting == setting;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.mdBorder,
        border: Border.all(
          color: isSelected ? color : AppColors.border,
          width: isSelected ? 2.0 : 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => setState(() => _selectedSetting = setting),
          borderRadius: AppRadius.mdBorder,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(isSelected ? 0.15 : 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.cardTitle.copyWith(
                          fontSize: 15,
                          color: isSelected ? color : AppColors.charcoal,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: AppTypography.caption.copyWith(color: AppColors.slate),
                      ),
                    ],
                  ),
                ),
                Radio<CareSetting>(
                  value: setting,
                  groupValue: _selectedSetting,
                  activeColor: color,
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedSetting = val);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

