import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import 'application_detail_screen.dart';

class CastingDetailAgentScreen extends StatelessWidget {
  const CastingDetailAgentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('DÉTAIL DU CASTING', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'L\'Ombre de Paris',
              style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            const Text(
              'Long Métrage • Paris, France',
              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 24),
            Text(
              'Description de l\'offre',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 12),
            ),
            const SizedBox(height: 12),
            const Text(
              'Nous recherchons des acteurs talentueux pour un projet de long métrage se déroulant dans le Paris des années 50. Une expérience préalable en théâtre est un plus.',
              style: TextStyle(color: AppColors.textSecondaryDark, height: 1.5, fontSize: 14),
            ),
            const SizedBox(height: 40),
            
            // exclusive Applicants Section
            const Text(
              'CANDIDATS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 16),
            _buildApplicantRow(context, 'Lucas Seu', 'Rôle Principal : Jean'),
            _buildApplicantRow(context, 'Perez Morel', 'Second Rôle : Sophie'),
            _buildApplicantRow(context, 'Falcao Junior', 'Rôle Secondaire : Inspecteur'),
          ],
        ),
      ),
    );
  }

  Widget _buildApplicantRow(BuildContext context, String name, String role) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ApplicationDetailScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.borderDark),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/user_avatar.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(role, style: const TextStyle(color: AppColors.textSecondaryDark, fontSize: 12)),
                ],
              ),
            ),
            const Icon(LucideIcons.chevronRight, color: AppColors.textSecondaryDark, size: 20),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }
}
