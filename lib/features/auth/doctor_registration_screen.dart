import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_text_field.dart';
import '../../app/routes/app_routes.dart';

class DoctorRegistrationScreen extends StatefulWidget {
  const DoctorRegistrationScreen({super.key});

  @override
  State<DoctorRegistrationScreen> createState() => _DoctorRegistrationScreenState();
}

class _DoctorRegistrationScreenState extends State<DoctorRegistrationScreen> {
  final _nameController = TextEditingController(text: 'Dr. Muhammad Nouman');
  final _licenseController = TextEditingController(text: 'PMC-92810-A');
  final _hospitalController = TextEditingController(text: 'Central Teaching Hospital');
  final _emailController = TextEditingController(text: 'dr.nouman@nourdoc.health');
  final _phoneController = TextEditingController(text: '+92 300 1234567');
  String _specialty = 'Internal Medicine';

  final List<String> _specialties = [
    'Internal Medicine',
    'Cardiology',
    'Pulmonology',
    'General Surgery',
    'Pediatrics',
    'Emergency Medicine',
    'Orthopedics',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _licenseController.dispose();
    _hospitalController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Clinician Onboarding', style: AppTypography.cardTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Register Your Clinical Profile',
                style: AppTypography.pageTitle,
              ),
              const SizedBox(height: 6),
              Text(
                'Setup your verified practitioner credentials for automated medical documentation and AI assistance.',
                style: AppTypography.body.copyWith(color: AppColors.slate),
              ),
              const SizedBox(height: 24),
              AppTextField(
                label: 'Full Name with Title',
                hintText: 'e.g. Dr. Jane Smith, MD',
                controller: _nameController,
                prefixIcon: const Icon(Icons.person_outline, color: AppColors.slate),
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Medical Registration / License Number',
                hintText: 'e.g. MED-882190',
                controller: _licenseController,
                prefixIcon: const Icon(Icons.verified_outlined, color: AppColors.slate),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Primary Medical Specialty', style: AppTypography.label),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _specialty,
                        isExpanded: true,
                        items: _specialties.map((s) {
                          return DropdownMenuItem(
                            value: s,
                            child: Text(s, style: AppTypography.bodyMedium),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _specialty = val);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Primary Hospital / Practice Setting',
                hintText: 'e.g. Metropolitan General Hospital',
                controller: _hospitalController,
                prefixIcon: const Icon(Icons.local_hospital_outlined, color: AppColors.slate),
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Official Email Address',
                hintText: 'name@hospital.org',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email_outlined, color: AppColors.slate),
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Contact Phone Number',
                hintText: '+1 (555) 000-0000',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.slate),
              ),
              const SizedBox(height: 32),
              AppButton(
                label: 'Complete Registration',
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.verification);
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

