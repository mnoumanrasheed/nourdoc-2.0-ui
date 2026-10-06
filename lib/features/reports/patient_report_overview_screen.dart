import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../models/mock/mock_models.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/clinical_badges.dart';
import '../../shared/widgets/app_audio_player.dart';
import '../../app/routes/app_routes.dart';

class PatientReportOverviewScreen extends StatefulWidget {
  final MockConsultation? consultation;

  const PatientReportOverviewScreen({super.key, this.consultation});

  @override
  State<PatientReportOverviewScreen> createState() => _PatientReportOverviewScreenState();
}

class _PatientReportOverviewScreenState extends State<PatientReportOverviewScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late MockConsultation _consultation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _consultation = widget.consultation ?? MockData.consultations.first;
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
        title: Text('Clinical Report', style: AppTypography.cardTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Exporting report as PDF...')),
              );
            },
            tooltip: 'Export PDF',
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sharing clinical report...')),
              );
            },
            tooltip: 'Share',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Unified Clinical Report Header
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
                vertical: 12,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _consultation.patientName,
                              style: AppTypography.cardTitle.copyWith(fontSize: 17),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${_consultation.patientAge}y • ${_consultation.patientGender} • ${_consultation.visitType.label}',
                              style: AppTypography.metadata,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      CareSettingBadge(setting: _consultation.careSetting),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.schedule, size: 14, color: AppColors.slate),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                '${_consultation.dateTime} (${_consultation.duration})',
                                style: AppTypography.caption,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      StatusChip(status: _consultation.status),
                    ],
                  ),
                ],
              ),
            ),

            // Tab Bar
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: AppColors.deepJade,
                labelColor: AppColors.deepJade,
                unselectedLabelColor: AppColors.slate,
                labelStyle: AppTypography.metadata.copyWith(fontWeight: FontWeight.w700),
                unselectedLabelStyle: AppTypography.metadata,
                tabs: const [
                  Tab(text: 'Overview'),
                  Tab(text: 'SOAP Note'),
                  Tab(text: 'ICD-10 & CPT'),
                  Tab(text: 'Evidence'),
                  Tab(text: 'Risk Review'),
                ],
              ),
            ),

            // Tab View
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOverviewTab(),
                  _buildSoapTab(),
                  _buildCodingTab(),
                  _buildEvidenceTab(),
                  _buildRiskTab(),
                ],
              ),
            ),

            // Bottom Review CTA Bar
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
                vertical: 12,
              ),
              child: AppButton(
                label: 'Sign Off & Finalize Clinical Record',
                icon: Icons.check_circle_outline,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.finalClinicalReview,
                    arguments: _consultation,
                  );
                },
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
        // Audio player snippet
        const AppAudioPlayer(totalDuration: '11:45'),
        const SizedBox(height: 14),

        // Primary Clinical Assessment
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
              Text('Primary Clinical Assessment', style: AppTypography.cardTitle.copyWith(fontSize: 15)),
              const SizedBox(height: 8),
              Text(_consultation.primaryDiagnosis, style: AppTypography.bodyMedium),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.clinicalMist,
                  borderRadius: AppRadius.smBorder,
                ),
                child: Text(
                  'Assessment synthesized from 11m 45s encounter transcript and previous medical history.',
                  style: AppTypography.caption.copyWith(color: AppColors.slate),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Summary Counts
        Row(
          children: [
            Expanded(
              child: _buildSummaryCard(
                'Codes Suggested',
                '${_consultation.codings.length}',
                Icons.receipt_long_outlined,
                AppColors.deepJade,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSummaryCard(
                'Risk Signals',
                '${_consultation.riskSignals.length}',
                Icons.warning_amber_rounded,
                AppColors.warmAmber,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSummaryCard(
                'Evidence Points',
                '${_consultation.evidenceList.length}',
                Icons.verified_outlined,
                AppColors.clinicalBlue,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSoapTab() {
    final soap = _consultation.soap;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
      children: [
        _buildSoapCard('S — Subjective', soap.subjective, AppColors.deepJade),
        const SizedBox(height: 12),
        _buildSoapCard('O — Objective', soap.objective, AppColors.clinicalBlue),
        const SizedBox(height: 12),
        _buildSoapCard('A — Assessment', soap.assessment, AppColors.warmAmber),
        const SizedBox(height: 12),
        _buildSoapCard('P — Plan', soap.plan, AppColors.indigo),
      ],
    );
  }

  Widget _buildSoapCard(String title, String content, Color accentColor) {
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
          Row(
            children: [
              Container(
                width: 4,
                height: 16,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(title, style: AppTypography.cardTitle.copyWith(fontSize: 15, color: accentColor)),
            ],
          ),
          const SizedBox(height: 10),
          Text(content, style: AppTypography.body.copyWith(height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildCodingTab() {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
      itemCount: _consultation.codings.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final coding = _consultation.codings[index];
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.paleJade,
                  borderRadius: AppRadius.xsBorder,
                ),
                child: Text(
                  coding.code,
                  style: AppTypography.metadata.copyWith(fontWeight: FontWeight.w700, color: AppColors.deepJade),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(coding.description, style: AppTypography.bodyMedium.copyWith(fontSize: 13)),
                    const SizedBox(height: 2),
                    Text('${coding.category} • ${(coding.confidence * 100).toInt()}% confidence', style: AppTypography.caption),
                  ],
                ),
              ),
              Icon(
                coding.isConfirmed ? Icons.check_circle : Icons.check_circle_outline,
                color: coding.isConfirmed ? AppColors.deepJade : AppColors.slateLight,
                size: 20,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEvidenceTab() {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
      itemCount: _consultation.evidenceList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final ev = _consultation.evidenceList[index];
        return Container(
          padding: const EdgeInsets.all(14),
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
                  Text(ev.type, style: AppTypography.caption.copyWith(fontWeight: FontWeight.w700, color: AppColors.deepJade)),
                  Text(ev.timestamp, style: AppTypography.caption.copyWith(color: AppColors.deepJade, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 6),
              Text(ev.text, style: AppTypography.body.copyWith(fontStyle: FontStyle.italic, fontSize: 13)),
              const SizedBox(height: 6),
              Text(ev.speaker, style: AppTypography.caption.copyWith(color: AppColors.slate)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRiskTab() {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
      itemCount: _consultation.riskSignals.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final r = _consultation.riskSignals[index];
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppRadius.mdBorder,
            border: Border.all(color: r.severityColor.withOpacity(0.4), width: 1.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning_amber_rounded, size: 18, color: r.severityColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(r.title, style: AppTypography.cardTitle.copyWith(fontSize: 14)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(r.description, style: AppTypography.body.copyWith(fontSize: 13)),
              const SizedBox(height: 8),
              Text('Why Flagged: ${r.whyFlagged}', style: AppTypography.caption.copyWith(fontStyle: FontStyle.italic)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryCard(String title, String val, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.mdBorder,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(height: 8),
          Text(val, style: AppTypography.cardTitle.copyWith(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(title, style: AppTypography.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

