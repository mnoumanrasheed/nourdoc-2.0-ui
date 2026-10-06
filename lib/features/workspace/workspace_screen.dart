import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../models/mock/mock_data.dart';
import '../../models/mock/mock_models.dart';
import '../../shared/widgets/brand_logo.dart';
import '../../shared/widgets/encounter_card.dart';
import '../../shared/widgets/metric_card.dart';
import '../../app/routes/app_routes.dart';

class WorkspaceScreen extends StatefulWidget {
  const WorkspaceScreen({super.key});

  @override
  State<WorkspaceScreen> createState() => _WorkspaceScreenState();
}

class _WorkspaceScreenState extends State<WorkspaceScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'General OPD', 'ER', 'IPD', 'OT'];

  @override
  Widget build(BuildContext context) {
    final consultations = MockData.consultations;
    final needsAttentionList = consultations.where((c) => c.needsAttention).toList();

    List<MockConsultation> filteredList = consultations;
    if (_selectedFilter != 'All') {
      if (_selectedFilter == 'General OPD') {
        filteredList = consultations.where((c) => c.careSetting == CareSetting.opd).toList();
      } else if (_selectedFilter == 'ER') {
        filteredList = consultations.where((c) => c.careSetting == CareSetting.emergency).toList();
      } else if (_selectedFilter == 'IPD') {
        filteredList = consultations.where((c) => c.careSetting == CareSetting.ipd).toList();
      } else if (_selectedFilter == 'OT') {
        filteredList = consultations.where((c) => c.careSetting == CareSetting.ot).toList();
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: NourDocLogo(height: 28),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 22, color: AppColors.charcoal),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.patientSearch);
            },
          ),
          IconButton(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.notifications_none_outlined, size: 22, color: AppColors.charcoal),
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: AppColors.rose,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.notifications);
            },
          ),
          const SizedBox(width: 4),
          // Clinician Avatar matching Figma top-right
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.profile);
            },
            child: const CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.deepJade,
              child: Text(
                'AA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.screenHorizontal),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.deepJade,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 400));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
              vertical: 14,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tracking label & Greeting header
                Text(
                  'CLINICAL WORKSPACE',
                  style: AppTypography.caption.copyWith(
                    letterSpacing: 1.2,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.freshJade,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Good morning, Dr. Ahmed',
                  style: AppTypography.pageTitle.copyWith(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    color: AppColors.charcoal,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Your clinical workspace is ready.',
                  style: AppTypography.body.copyWith(
                    fontSize: 13.5,
                    color: AppColors.slate,
                  ),
                ),
                const SizedBox(height: 18),

                // 3 Metric Cards side-by-side matching Figma
                Row(
                  children: const [
                    Expanded(
                      child: MetricCard(
                        topLabel: 'Total',
                        value: '08',
                        valueColor: AppColors.deepJade,
                        sublabel: 'Total encounters',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: MetricCard(
                        topLabel: 'In progress',
                        value: '02',
                        valueColor: AppColors.warmAmber,
                        sublabel: 'Review req.',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: MetricCard(
                        topLabel: 'Signed off',
                        value: '06',
                        valueColor: AppColors.freshJade,
                        sublabel: 'Records signed',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Section: NEEDS ATTENTION
                Row(
                  children: [
                    Text(
                      'NEEDS ATTENTION',
                      style: AppTypography.label.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: AppColors.charcoal,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.roseLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${needsAttentionList.length}',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.rose,
                          fontWeight: FontWeight.w800,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Needs Attention Cards with left accent bar
                ...needsAttentionList.map(
                  (c) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: NeedsAttentionCard(
                      consultation: c,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.consultationDetail,
                          arguments: c,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Section: TODAY'S ENCOUNTERS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "TODAY'S ENCOUNTERS",
                      style: AppTypography.label.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: AppColors.charcoal,
                        letterSpacing: 0.5,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.consultations);
                      },
                      child: Text(
                        'See all',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.deepJade,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Horizontal Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _filters.map((filter) {
                      final isSelected = _selectedFilter == filter;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: InkWell(
                          onTap: () => setState(() => _selectedFilter = filter),
                          borderRadius: BorderRadius.circular(20),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6.5),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.deepJade : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected ? AppColors.deepJade : AppColors.border,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              filter,
                              style: AppTypography.caption.copyWith(
                                color: isSelected ? Colors.white : AppColors.slate,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 12),

                // Today's Encounters list matching Figma
                ...filteredList.map(
                  (c) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: EncounterCard(
                      consultation: c,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.consultationDetail,
                          arguments: c,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
