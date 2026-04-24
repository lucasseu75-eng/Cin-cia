import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../utils/page_transitions.dart';
import 'casting_result_screen.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight;
    final textPrimary = isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondary = isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final surfaceColor = isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight;
    final borderColor = isDarkMode ? AppColors.borderDark : AppColors.borderLight;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: surfaceColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderColor),
                        boxShadow: !isDarkMode ? AppColors.shadowLight : null,
                      ),
                      child: Icon(LucideIcons.chevronLeft, color: textPrimary, size: 20),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NOTIFICATIONS',
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const Text(
                        'RESTEZ CONNECTÉ',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                children: [
                   _buildSectionTitle('AUJOURD\'HUI', textSecondary).animate().fadeIn(delay: 200.ms),
                  const SizedBox(height: 16),
                  
                  // Notification résultat de casting (tappable)
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      CineciaTransition(page: const CastingResultScreen(status: CastingResultStatus.selected)),
                    ),
                    child: _buildNotificationItem(
                      context: context,
                      title: '🎉 Résultat de casting',
                      message: 'Félicitations ! Vous êtes sélectionné pour le rôle dans "In The Shadow". Appuyez pour voir le résultat.',
                      time: '10:15',
                      icon: LucideIcons.award,
                      isUnread: true,
                      accentColor: Colors.green,
                      surfaceColor: surfaceColor,
                      borderColor: borderColor,
                      textPrimary: textPrimary,
                      textSecondary: textSecondary,
                      isDarkMode: isDarkMode,
                    ),
                  ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 16),
                  
                  _buildNotificationItem(
                    context: context,
                    title: 'Nouveau Casting',
                    message: 'Warner Bros a publié "L\'Ombre de Paris". Un rôle correspond à votre profil.',
                    time: '12:45',
                    icon: LucideIcons.clapperboard,
                    isUnread: true,
                    surfaceColor: surfaceColor,
                    borderColor: borderColor,
                    textPrimary: textPrimary,
                    textSecondary: textSecondary,
                    isDarkMode: isDarkMode,
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 16),
                  _buildNotificationItem(
                    context: context,
                    title: 'Message Reçu',
                    message: 'Lucas Meyer vous a envoyé un nouveau script pour consultation.',
                    time: '09:30',
                    icon: LucideIcons.mail,
                    isUnread: true,
                    surfaceColor: surfaceColor,
                    borderColor: borderColor,
                    textPrimary: textPrimary,
                    textSecondary: textSecondary,
                    isDarkMode: isDarkMode,
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),
                  
                  const SizedBox(height: 40),
                  _buildSectionTitle('PLUS TÔT', textSecondary).animate().fadeIn(delay: 500.ms),
                  const SizedBox(height: 16),
                  _buildNotificationItem(
                    context: context,
                    title: 'Profil Consulté',
                    message: 'Un agent de Pathé Films a consulté votre book artistique.',
                    time: 'HIER',
                    icon: LucideIcons.eye,
                    isUnread: false,
                    surfaceColor: surfaceColor,
                    borderColor: borderColor,
                    textPrimary: textPrimary,
                    textSecondary: textSecondary,
                    isDarkMode: isDarkMode,
                  ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 16),
                  _buildNotificationItem(
                    context: context,
                    title: 'Candidature Acceptée',
                    message: 'Votre candidature pour "Le Silence" a été retenue par la production.',
                    time: 'HIER',
                    icon: LucideIcons.checkCircle,
                    isUnread: false,
                    surfaceColor: surfaceColor,
                    borderColor: borderColor,
                    textPrimary: textPrimary,
                    textSecondary: textSecondary,
                    isDarkMode: isDarkMode,
                  ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.1, end: 0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.w900,
        letterSpacing: 2.0,
      ),
    );
  }

  Widget _buildNotificationItem({
    required BuildContext context,
    required String title,
    required String message,
    required String time,
    required IconData icon,
    required bool isUnread,
    required Color surfaceColor,
    required Color borderColor,
    required Color textPrimary,
    required Color textSecondary,
    required bool isDarkMode,
    Color? accentColor,
  }) {
    final Color activeColor = accentColor ?? AppColors.primary;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread ? activeColor.withOpacity(0.05) : surfaceColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isUnread ? activeColor.withOpacity(0.3) : borderColor,
          width: 1,
        ),
        boxShadow: !isDarkMode && !isUnread ? AppColors.shadowLight : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isUnread ? activeColor : (isDarkMode ? AppColors.backgroundDark : const Color(0xFFF1F5F9)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: isUnread ? Colors.white : textPrimary, size: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        color: textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: textSecondary,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  style: TextStyle(
                    color: textPrimary.withOpacity(0.7),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
