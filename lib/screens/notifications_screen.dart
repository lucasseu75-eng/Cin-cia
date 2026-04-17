import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
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
                        color: AppColors.surfaceDark,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.borderDark),
                      ),
                      child: const Icon(LucideIcons.chevronLeft, color: Colors.white, size: 20),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NOTIFICATIONS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                        ),
                      ),
                      Text(
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
                   _buildSectionTitle('AUJOURD\'HUI').animate().fadeIn(delay: 200.ms),
                  const SizedBox(height: 16),
                  _buildNotificationItem(
                    title: 'Nouveau Casting',
                    message: 'Warner Bros a publié "L\'Ombre de Paris". Un rôle correspond à votre profil.',
                    time: '12:45',
                    icon: LucideIcons.clapperboard,
                    isUnread: true,
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 16),
                  _buildNotificationItem(
                    title: 'Message Reçu',
                    message: 'Lucas Meyer vous a envoyé un nouveau script pour consultation.',
                    time: '09:30',
                    icon: LucideIcons.mail,
                    isUnread: true,
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),
                  
                  const SizedBox(height: 40),
                  _buildSectionTitle('PLUS TÔT').animate().fadeIn(delay: 500.ms),
                  const SizedBox(height: 16),
                  _buildNotificationItem(
                    title: 'Profil Consulté',
                    message: 'Un agent de Pathé Films a consulté votre book artistique.',
                    time: 'HIER',
                    icon: LucideIcons.eye,
                    isUnread: false,
                  ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 16),
                  _buildNotificationItem(
                    title: 'Candidature Acceptée',
                    message: 'Votre candidature pour "Le Silence" a été retenue par la production.',
                    time: 'HIER',
                    icon: LucideIcons.checkCircle,
                    isUnread: false,
                  ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.1, end: 0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.textSecondaryDark,
        fontSize: 12,
        fontWeight: FontWeight.w900,
        letterSpacing: 2.0,
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String message,
    required String time,
    required IconData icon,
    required bool isUnread,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread ? AppColors.primary.withOpacity(0.05) : AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isUnread ? AppColors.primary.withOpacity(0.3) : AppColors.borderDark,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isUnread ? AppColors.primary : AppColors.backgroundDark,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
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
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        color: AppColors.textSecondaryDark,
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
                    color: Colors.white.withOpacity(0.7),
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
