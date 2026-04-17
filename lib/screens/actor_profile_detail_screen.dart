import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';

class ActorProfileDetailScreen extends StatelessWidget {
  const ActorProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          // Main Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Immersive Image Header
                Stack(
                  children: [
                    Container(
                      height: 500,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/user_avatar.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Gradient Mask
                    Container(
                      height: 500,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColors.backgroundDark.withOpacity(0.5),
                            AppColors.backgroundDark,
                          ],
                        ),
                      ),
                    ),
                    // Back Button
                    Positioned(
                      top: 60,
                      left: 20,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(LucideIcons.chevronLeft, color: Colors.white),
                        ),
                      ),
                    ),
                    // Name and Tag
                    Positioned(
                      bottom: 40,
                      left: 24,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('CANDIDATURE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Thomas Durand',
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontSize: 48,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
                    ),
                  ],
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('POSTE VISÉ'),
                      const SizedBox(height: 12),
                      _buildInfoCard('Long Métrage : "L\'Ombre de Paris"'),
                      
                      const SizedBox(height: 32),
                      _buildSectionTitle('PROFIL DE L\'ACTEUR'),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(child: _buildSmallDetailCard('ÂGE', '30-40 ans')),
                          const SizedBox(width: 16),
                          Expanded(child: _buildSmallDetailCard('LOCALISATION', 'Paris, France')),
                        ],
                      ),
                      
                      const SizedBox(height: 32),
                      _buildSectionTitle('NOTE DE MOTIVATION'),
                      const SizedBox(height: 12),
                      Text(
                        '"Passionné par le cinéma depuis mon plus jeune âge, j\'ai suivi une formation intensive au Cours Florent. Ce rôle dans \'Long Métrage : "L\'Ombre de Paris"\' correspond parfaitement à mon univers artistique et à mes expériences passées en théâtre classique."',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      _buildSectionTitle('EXPÉRIENCE'),
                      const SizedBox(height: 12),
                      _buildTextTagList(['Cinéma (5 ans)', 'Théâtre (3 ans)', 'Publicité']),
                      
                      const SizedBox(height: 32),
                      _buildSectionTitle('LANGUES PARLÉES'),
                      const SizedBox(height: 12),
                      _buildTextTagList(['Français (Natif)', 'Anglais (Bilingue)', 'Espagnol (Intermédiaire)']),
                      
                      const SizedBox(height: 120), // Bottom padding for fixed button
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Fixed Bottom Button
          Positioned(
            bottom: 30,
            left: 24,
            right: 24,
            child: PrimaryButton(
              text: 'CONTACTER L\'ACTEUR',
              icon: const Icon(LucideIcons.messageCircle),
              onPressed: () {},
            ).animate().slideY(begin: 1.0, end: 0, duration: 600.ms, curve: Curves.easeOutCubic),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.textSecondaryDark,
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildInfoCard(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
      ),
    );
  }

  Widget _buildSmallDetailCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondaryDark, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildTextTagList(List<String> tags) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: tags.map((tag) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderDark),
        ),
        child: Text(tag, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
      )).toList(),
    );
  }
}
