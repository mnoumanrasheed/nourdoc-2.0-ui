import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../models/mock/mock_models.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/clinical_badges.dart';
import '../../app/routes/app_routes.dart';

class PatientProfileScreen extends StatefulWidget {
  final MockPatient? patient;

  const PatientProfileScreen({super.key, this.patient});

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late MockPatient _patient;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _patient = widget.patient ?? MockData.patients.first;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Patient Profile', style: AppTypography.cardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Patient Header Card
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
                vertical: 16,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: AppColors.paleJade,
                        child: Text(
                          _patient.name.substring(0, 1),
                          style: AppTypography.pageTitle.copyWith(
                            color: AppColors.deepJade,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_patient.name, style: AppTypography.cardTitle.copyWith(fontSize: 18)),
                                CareSettingBadge(setting: _patient.careSetting, compact: true),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${_patient.id} • ${_patient.mrn} • ${_patient.age}y • ${_patient.gender}',
                              style: AppTypography.metadata,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.phone_outlined, size: 14, color: AppColors.slate),
                                const SizedBox(width: 4),
                                Text(_patient.phone, style: AppTypography.caption),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    label: 'Start New Clinical Encounter',
                    icon: Icons.add_circle_outline,
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.careSetting,
                        arguments: _patient,
                      );
                    },
                  ),
                ],
              ),
            ),

            // Tab Bar
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.deepJade,
                labelColor: AppColors.deepJade,
                unselectedLabelColor: AppColors.slate,
                labelStyle: AppTypography.metadata.copyWith(fontWeight: FontWeight.w700),
                unselectedLabelStyle: AppTypography.metadata,
                tabs: const [
                  Tab(text: 'Overview'),
                  Tab(text: 'History'),
                  Tab(text: 'Reports'),
                  Tab(text: 'Timeline'),
                ],
              ),
            ),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOverviewTab(),
                  _buildHistoryTab(),
                  _buildReportsTab(),
                  _buildTimelineTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewTab() {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
      children: [
        // Chief Complaint
        _buildSectionCard(
          title: 'Active Chief Complaint',
          child: Text(
            _patient.chiefComplaint,
            style: AppTypography.body,
          ),
        ),
        const SizedBox(height: 14),

        // Latest Vitals
        _buildSectionCard(
          title: 'Latest Vital Signs',
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2.2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              _buildVitalTile('Blood Pressure', _patient.vitals.bloodPressure, Icons.favorite_border),
              _buildVitalTile('Heart Rate', _patient.vitals.pulse, Icons.monitor_heart_outlined),
              _buildVitalTile('Temperature', _patient.vitals.temperature, Icons.thermostat_outlined),
              _buildVitalTile('Respiration', _patient.vitals.respiration, Icons.air_outlined),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Active Medications
        _buildSectionCard(
          title: 'Active Medications',
          child: Column(
            children: const [
              _MedicationRow(name: 'Lisinopril 10mg', dose: '1 tablet PO daily (Hypertension)'),
              Divider(height: 16),
              _MedicationRow(name: 'Albuterol HFA Inhaler', dose: '1-2 puffs q4-6h PRN dyspnea'),
              Divider(height: 16),
              _MedicationRow(name: 'Atorvastatin 20mg', dose: '1 tablet PO at bedtime'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryTab() {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
      children: [
        _buildSectionCard(
          title: 'Past Medical History',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('• Essential Hypertension (Diagnosed 2021)'),
              SizedBox(height: 6),
              Text('• Seasonal Allergic Rhinitis (Chronic)'),
              SizedBox(height: 6),
              Text('• Mild Reactive Airway Disease'),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _buildSectionCard(
          title: 'Known Allergies',
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.roseLight,
                  borderRadius: AppRadius.smBorder,
                ),
                child: Text(
                  'Penicillin (Hives / Rash)',
                  style: AppTypography.metadata.copyWith(
                    color: AppColors.rose,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReportsTab() {
    final consultations = MockData.consultations;
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
      itemCount: consultations.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final c = consultations[index];
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppRadius.mdBorder,
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.paleJade,
                  borderRadius: AppRadius.smBorder,
                ),
                child: const Icon(Icons.description_outlined, color: AppColors.deepJade),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.primaryDiagnosis, style: AppTypography.cardTitle.copyWith(fontSize: 14)),
                    const SizedBox(height: 4),
                    Text('${c.dateTime} • ${c.duration}', style: AppTypography.caption),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.slate),
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.reportOverview, arguments: c);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimelineTab() {
    final events = [
      {'date': 'Today, 10:30 AM', 'title': 'Follow-up Consultation', 'dept': 'OPD - Bronchitis'},
      {'date': 'Oct 02, 2026', 'title': 'Routine Lab Panel Completed', 'dept': 'Pathology - CBC, Electrolytes'},
      {'date': 'Sep 25, 2026', 'title': 'Prescription Refilled', 'dept': 'Pharmacy - Lisinopril 10mg'},
      {'date': 'Aug 14, 2026', 'title': 'Initial Clinical Encounter', 'dept': 'OPD - Dr. Nouman'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final ev = events[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: AppColors.deepJade,
                    shape: BoxShape.circle,
                  ),
                ),
                if (index < events.length - 1)
                  Container(
                    width: 2,
                    height: 54,
                    color: AppColors.border,
                  ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ev['title']!, style: AppTypography.cardTitle.copyWith(fontSize: 14)),
                    const SizedBox(height: 2),
                    Text(ev['dept']!, style: AppTypography.caption),
                    const SizedBox(height: 2),
                    Text(
                      ev['date']!,
                      style: AppTypography.caption.copyWith(color: AppColors.deepJade, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.mdBorder,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.cardTitle.copyWith(fontSize: 15)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildVitalTile(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.clinicalMist,
        borderRadius: AppRadius.smBorder,
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.deepJade),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, style: AppTypography.caption),
                Text(value, style: AppTypography.metadata.copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MedicationRow extends StatelessWidget {
  final String name;
  final String dose;

  const _MedicationRow({required this.name, required this.dose});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.medication_outlined, size: 20, color: AppColors.deepJade),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: AppTypography.bodyMedium),
              Text(dose, style: AppTypography.caption),
            ],
          ),
        ),
      ],
    );
  }
}

