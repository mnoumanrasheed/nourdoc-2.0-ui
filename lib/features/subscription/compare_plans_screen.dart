import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../app/routes/app_routes.dart';

class ComparePlansScreen extends StatelessWidget {
  const ComparePlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      {'feature': 'Monthly Encounters', 'free': '10', 'starter': '75', 'pro': 'Unlimited', 'ent': 'Custom'},
      {'feature': 'SOAP Note Generation', 'free': 'Standard', 'starter': 'Full', 'pro': 'Advanced', 'ent': 'Custom Templates'},
      {'feature': 'ICD-10 & CPT Suggestions', 'free': 'Basic', 'starter': 'Yes', 'pro': 'Priority Verified', 'ent': 'Hospital Master Code'},
      {'feature': 'Audio ↔ Transcript Link', 'free': 'No', 'starter': 'Yes', 'pro': 'Traceable', 'ent': 'Full Audit Trail'},
      {'feature': 'Clinical Risk Analysis', 'free': 'No', 'starter': 'Basic', 'pro': 'Multi-signal', 'ent': 'Enterprise Alerting'},
      {'feature': 'EHR Direct Integration', 'free': 'No', 'starter': 'No', 'pro': 'FHIR / HL7', 'ent': 'Dedicated Gateway'},
      {'feature': 'Support SLA', 'free': 'Community', 'starter': 'Standard', 'pro': 'Priority (4hr)', 'ent': '24/7 Dedicated'},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Compare NourDoc Plans', style: AppTypography.cardTitle),
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
              Text('Feature Matrix Comparison', style: AppTypography.sectionTitle),
              const SizedBox(height: 6),
              Text(
                'Evaluate clinical features side by side across tiers.',
                style: AppTypography.caption,
              ),
              const SizedBox(height: 16),

              // Comparison Table Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.mdBorder,
                  border: Border.all(color: AppColors.border),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 22,
                    headingRowColor: WidgetStateProperty.all(AppColors.clinicalMist),
                    columns: const [
                      DataColumn(label: Text('Feature', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Free', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Starter\n(\$49)', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Pro\n(\$99)', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.deepJade))),
                      DataColumn(label: Text('Enterprise', style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: features.map((f) {
                      return DataRow(
                        cells: [
                          DataCell(Text(f['feature']!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                          DataCell(Text(f['free']!, style: const TextStyle(fontSize: 12))),
                          DataCell(Text(f['starter']!, style: const TextStyle(fontSize: 12))),
                          DataCell(Text(f['pro']!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.deepJade))),
                          DataCell(Text(f['ent']!, style: const TextStyle(fontSize: 12))),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.upgradePlan);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.deepJade,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(borderRadius: AppRadius.mdBorder),
                ),
                child: const Text('Upgrade to Professional Workspace', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

