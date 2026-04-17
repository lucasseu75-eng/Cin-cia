import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import 'actor_profile_detail_screen.dart';
import 'create_offer_screen.dart';
import 'notifications_screen.dart';

class AgentHomeScreen extends ConsumerWidget {
  const AgentHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight;
    final surfaceColor = isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight;
    final textPrimary = isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondary = isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final borderColor = isDarkMode ? AppColors.borderDark : AppColors.borderLight;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CANDIDATS',
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        'ESPACE PRODUCTION',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Notification Icon with Badge
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: surfaceColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: borderColor),
                                boxShadow: !isDarkMode ? AppColors.shadowLight : null,
                              ),
                              child: Icon(LucideIcons.bell, color: textPrimary, size: 20),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: surfaceColor, width: 1.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Profile Avatar
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: borderColor),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/user_avatar.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2, end: 0),
              const SizedBox(height: 32),
              
              // Header Stats
              Row(
                children: [
                  Expanded(child: _buildStatCard(context, 'CANDIDATS', '4', surfaceColor, borderColor, textSecondary, textPrimary).animate().fadeIn(duration: 400.ms, delay: 100.ms).slideX(begin: -0.1, end: 0)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildStatCard(context, 'OFFRES ACTIVES', '3', surfaceColor, borderColor, textSecondary, textPrimary).animate().fadeIn(duration: 400.ms, delay: 200.ms).slideX(begin: 0.1, end: 0)),
                ],
              ),
              const SizedBox(height: 32),
              
              // Publish Button
              PrimaryButton(
                text: 'PUBLIER UN CASTING',
                icon: const Icon(LucideIcons.plus),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CreateOfferScreen()),
                  );
                },
              ).animate().fadeIn(duration: 400.ms, delay: 300.ms).scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1)),
              const SizedBox(height: 40),
              
              // List Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Tous les Candidats',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                            color: textPrimary,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('FILTRER',
                        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 1.0)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildApplicationItem(context, 'Lucas Seu', 'LONG MÉTRAGE : "L\'OMBRE DE PARIS"', 'PIANO • ESCRIME', '30-40 ans', 'Paris, France', '2024-05-10', surfaceColor, borderColor, textPrimary, textSecondary),
              _buildApplicationItem(context, 'Perez Morel', 'LONG MÉTRAGE : "L\'OMBRE DE PARIS"', 'CHANT • DANSE', '20-30 ans', 'Lyon, France', '2024-05-11', surfaceColor, borderColor, textPrimary, textSecondary),
              _buildApplicationItem(context, 'Falcao Junior', 'LONG MÉTRAGE : "L\'OMBRE DE PARIS"', 'BOXE • ÉQUITATION', '25-35 ans', 'Abidjan, CI', '2024-05-12', surfaceColor, borderColor, textPrimary, textSecondary),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value, Color surface, Color border, Color labelColor, Color valueColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: border),
        boxShadow: Theme.of(context).brightness == Brightness.light ? AppColors.shadowLight : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: labelColor, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.0)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(color: valueColor, fontSize: 32, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }

  Widget _buildApplicationItem(BuildContext context, String name, String project, String skills, String age, String location, String date, Color surface, Color border, Color nameColor, Color secondaryColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: border),
        boxShadow: Theme.of(context).brightness == Brightness.light ? AppColors.shadowLight : null,
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name, 
                        style: TextStyle(color: nameColor, fontWeight: FontWeight.w900, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(date, style: TextStyle(color: secondaryColor, fontSize: 10)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  skills, 
                  style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900, fontSize: 11, letterSpacing: 0.5),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(LucideIcons.clock, size: 14, color: secondaryColor),
                    const SizedBox(width: 4),
                    Text(age, style: TextStyle(color: secondaryColor, fontSize: 11)),
                    const SizedBox(width: 12),
                    Icon(LucideIcons.mapPin, size: 14, color: secondaryColor),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location, 
                        style: TextStyle(color: secondaryColor, fontSize: 11),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ActorProfileDetailScreen()),
              );
            },
            icon: Icon(LucideIcons.chevronRight, color: secondaryColor),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms, delay: 300.ms).slideY(begin: 0.1, end: 0);
  }
}
