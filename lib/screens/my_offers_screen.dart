import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import 'casting_detail_agent_screen.dart';
import 'notifications_screen.dart';

class MyOffersScreen extends StatelessWidget {
  const MyOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              // Top Bar (Reproduced from AgentHomeScreen)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CASTINGS',
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const Text(
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
                      // Notification Icon
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
              Text(
                'Gérez vos castings et candidatures.',
                style: TextStyle(color: textSecondary, fontSize: 14),
              ).animate().fadeIn(duration: 400.ms, delay: 200.ms).slideX(begin: -0.1, end: 0),
              
              const SizedBox(height: 32),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildOfferItem(context, 'L\'Ombre de Paris', 'Long Métrage', 'Paris', 4, surfaceColor, borderColor, textPrimary, textSecondary),
                  _buildOfferItem(context, 'Série "Z" - Saison 2', 'Série TV', 'Abidjan', 12, surfaceColor, borderColor, textPrimary, textSecondary),
                  _buildOfferItem(context, 'Pub Coca-Cola', 'Publicité', 'Londres', 8, surfaceColor, borderColor, textPrimary, textSecondary),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOfferItem(BuildContext context, String title, String type, String location, int applicantCount, Color surface, Color border, Color nameColor, Color secondaryColor) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CastingDetailAgentScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: border),
          boxShadow: !isDarkMode ? AppColors.shadowLight : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(type.toUpperCase(), style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 10)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    location, 
                    textAlign: TextAlign.right,
                    style: TextStyle(color: secondaryColor, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title, 
              style: TextStyle(color: nameColor, fontWeight: FontWeight.w900, fontSize: 20),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                // Mini Avatars
                SizedBox(
                  width: 80,
                  height: 32,
                  child: Stack(
                    children: List.generate(applicantCount > 3 ? 3 : applicantCount, (index) {
                      return Positioned(
                        left: index * 18.0,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: surface, width: 2),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/user_avatar.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '+$applicantCount CANDIDATS',
                    style: TextStyle(color: secondaryColor, fontWeight: FontWeight.bold, fontSize: 11),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(LucideIcons.chevronRight, color: secondaryColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
